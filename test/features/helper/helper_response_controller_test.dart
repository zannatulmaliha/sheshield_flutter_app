import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/live_alert_status.dart';
import 'package:sheshield/features/helper/domain/entities/live_state.dart';
import 'package:sheshield/features/helper/domain/entities/my_response.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/entities/safety_status.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';
import 'package:sheshield/features/helper/domain/usecases/get_live_state_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/release_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/resolve_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_response_stage_usecase.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_response_provider.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_response_state.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_use_case_providers.dart';

class _FakeHelperAlertRepository implements HelperAlertRepository {
  _FakeHelperAlertRepository({this.live, this.liveFailure});

  LiveState? live;
  AppFailure? liveFailure;
  final stagesSent = <ResponseStage>[];
  var resolveCalls = 0;
  var releaseCalls = 0;

  @override
  Future<LiveState> fetchLiveState(String alertId) async {
    if (liveFailure != null) throw liveFailure!;
    return live ?? const LiveState(status: LiveAlertStatus.accepted);
  }

  @override
  Future<void> setResponseStage(String alertId, ResponseStage stage) async =>
      stagesSent.add(stage);

  @override
  Future<void> resolveAlert(String alertId) async => resolveCalls++;

  @override
  Future<void> releaseAlert(String alertId) async => releaseCalls++;

  @override
  Future<List<NearbyAlert>> fetchNearbyAlerts() => throw UnimplementedError();

  @override
  Future<AcceptedAlert?> acceptAlert(String alertId) => throw UnimplementedError();

  @override
  Future<SafetyStatus> fetchSafetyStatus(String alertId) => throw UnimplementedError();

  @override
  Future<MyResponse?> fetchCurrentResponse() async => null;
}

const _alertId = 'alert1';

({ProviderContainer container, HelperResponseController controller}) _start(
  _FakeHelperAlertRepository repository, {
  ResponseStage initialStage = ResponseStage.none,
}) {
  final container = ProviderContainer(
    overrides: [
      getLiveStateUseCaseProvider.overrideWithValue(GetLiveStateUseCase(repository)),
      setResponseStageUseCaseProvider
          .overrideWithValue(SetResponseStageUseCase(repository)),
      resolveAlertUseCaseProvider.overrideWithValue(ResolveAlertUseCase(repository)),
      releaseAlertUseCaseProvider.overrideWithValue(ReleaseAlertUseCase(repository)),
    ],
  );
  addTearDown(container.dispose);
  final provider = helperResponseControllerProvider(_alertId, initialStage);
  container.listen(provider, (_, __) {});
  return (container: container, controller: container.read(provider.notifier));
}

HelperResponseState _stateOf(ProviderContainer container, [ResponseStage? stage]) =>
    container.read(
      helperResponseControllerProvider(_alertId, stage ?? ResponseStage.none),
    );

void main() {
  test('the stage only moves forward', () async {
    final repository = _FakeHelperAlertRepository();
    final started = _start(repository);

    await started.controller.setStage(ResponseStage.arrived);
    await started.controller.setStage(ResponseStage.enRoute); // ignored

    expect(repository.stagesSent, [ResponseStage.arrived]);
    expect(_stateOf(started.container).stage, ResponseStage.arrived);
  });

  test('a live poll never moves the stage backwards', () async {
    final repository = _FakeHelperAlertRepository(
      live: const LiveState(
        status: LiveAlertStatus.accepted,
        stage: ResponseStage.enRoute,
      ),
    );
    final started = _start(repository, initialStage: ResponseStage.assisting);

    await pumpEventQueue();

    final state = _stateOf(started.container, ResponseStage.assisting);
    expect(state.stage, ResponseStage.assisting);
    expect(state.live, isNotNull);
  });

  test('the requester marking themselves safe ends the response', () async {
    final repository = _FakeHelperAlertRepository(
      live: const LiveState(status: LiveAlertStatus.resolved),
    );
    final started = _start(repository);

    await pumpEventQueue();

    expect(
      _stateOf(started.container).ended,
      HelperResponseEnd.requesterMarkedSafe,
    );
  });

  test('losing the lock (409) ends the response', () async {
    final repository = _FakeHelperAlertRepository(
      liveFailure: const AppFailure(message: 'not yours', statusCode: 409),
    );
    final started = _start(repository);

    await pumpEventQueue();

    expect(
      _stateOf(started.container).ended,
      HelperResponseEnd.notAssignedAnymore,
    );
  });

  test('an ordinary network failure is just a missed poll', () async {
    final repository = _FakeHelperAlertRepository(
      liveFailure: const AppFailure(message: 'No internet connection.'),
    );
    final started = _start(repository);

    await pumpEventQueue();

    expect(_stateOf(started.container).ended, isNull);
  });

  test('resolving and backing out each end the response once', () async {
    final resolveRepository = _FakeHelperAlertRepository();
    final resolving = _start(resolveRepository);
    await resolving.controller.resolve();
    expect(_stateOf(resolving.container).ended, HelperResponseEnd.resolvedByHelper);
    expect(resolveRepository.resolveCalls, 1);

    final releaseRepository = _FakeHelperAlertRepository();
    final backingOut = _start(releaseRepository);
    await backingOut.controller.backOut();
    expect(_stateOf(backingOut.container).ended, HelperResponseEnd.backedOut);
    expect(HelperResponseEnd.backedOut.userMessage, isNull);
  });
}
