import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_alarm_service.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/core/services/evidence_service.dart';
import 'package:sheshield/core/services/motion/motion_api.dart';
import 'package:sheshield/core/services/motion/motion_settings.dart';
import 'package:sheshield/core/services/push_service.dart';
import 'package:sheshield/core/services/ringtone_service.dart';
import 'package:sheshield/core/services/voice_distress_service.dart';

/// Riverpod handles to device services, so widgets and controllers never
/// reach for get_it themselves. Add a provider here when a migrated
/// feature needs another service.
final deviceSmsServiceProvider =
    Provider<DeviceSmsService>((_) => getIt<DeviceSmsService>());

final deviceLocationServiceProvider =
    Provider<DeviceLocationService>((_) => getIt<DeviceLocationService>());

final deviceAlarmServiceProvider =
    Provider<DeviceAlarmService>((_) => getIt<DeviceAlarmService>());

final pushServiceProvider = Provider<PushService>((_) => getIt<PushService>());

final evidenceServiceProvider =
    Provider<EvidenceService>((_) => getIt<EvidenceService>());

final ringtoneServiceProvider =
    Provider<RingtoneService>((_) => getIt<RingtoneService>());

final voiceDistressServiceProvider =
    Provider<VoiceDistressService>((_) => getIt<VoiceDistressService>());

final motionSettingsStoreProvider =
    Provider<MotionSettingsStore>((_) => getIt<MotionSettingsStore>());

final motionApiProvider = Provider<MotionApi>((_) => getIt<MotionApi>());
