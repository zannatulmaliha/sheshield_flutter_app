import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/presentation/screens/helper_alert_detail_screen.dart';
import 'package:sheshield/features/sos/presentation/screens/danger_zone_screen.dart';
import 'package:sheshield/features/sos/presentation/screens/notifications_screen.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_activated_view.dart';

part 'sos_routes.g.dart';

/// Full-screen "SOS Alert Sent" confirmation, shown as a transparent
/// overlay so it still reads as a modal floating over Home.
@TypedGoRoute<SosSentRoute>(path: '/sos-sent')
class SosSentRoute extends GoRouteData {
  const SosSentRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
        opaque: false,
        barrierColor: Colors.black87,
        barrierDismissible: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
        child: const SosActivatedView(),
      );
}

/// The signed-in user's own SOS history, reached from the home bell icon.
@TypedGoRoute<NotificationsRoute>(path: '/notifications')
class NotificationsRoute extends GoRouteData {
  const NotificationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationsScreen();
}

/// The Danger Zone heat map, reached from the home screen's quick actions.
@TypedGoRoute<DangerZoneRoute>(path: '/danger-zone')
class DangerZoneRoute extends GoRouteData {
  const DangerZoneRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DangerZoneScreen();
}

/// The one screen showing a helper's exact match (location + phone) after
/// they win an accept race. [$extra] carries the [AcceptedAlert]; it is
/// momentary race-won data, so it is never round-tripped through a URL.
@TypedGoRoute<HelperAlertDetailRoute>(path: '/helper-alert')
class HelperAlertDetailRoute extends GoRouteData {
  const HelperAlertDetailRoute({required this.$extra});

  final AcceptedAlert $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HelperAlertDetailScreen(alert: $extra);
}
