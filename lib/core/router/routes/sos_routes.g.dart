// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $sosSentRoute,
      $notificationsRoute,
      $dangerZoneRoute,
      $helperAlertDetailRoute,
    ];

RouteBase get $sosSentRoute => GoRouteData.$route(
      path: '/sos-sent',
      factory: $SosSentRouteExtension._fromState,
    );

extension $SosSentRouteExtension on SosSentRoute {
  static SosSentRoute _fromState(GoRouterState state) => const SosSentRoute();

  String get location => GoRouteData.$location(
        '/sos-sent',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationsRoute => GoRouteData.$route(
      path: '/notifications',
      factory: $NotificationsRouteExtension._fromState,
    );

extension $NotificationsRouteExtension on NotificationsRoute {
  static NotificationsRoute _fromState(GoRouterState state) =>
      const NotificationsRoute();

  String get location => GoRouteData.$location(
        '/notifications',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dangerZoneRoute => GoRouteData.$route(
      path: '/danger-zone',
      factory: $DangerZoneRouteExtension._fromState,
    );

extension $DangerZoneRouteExtension on DangerZoneRoute {
  static DangerZoneRoute _fromState(GoRouterState state) =>
      const DangerZoneRoute();

  String get location => GoRouteData.$location(
        '/danger-zone',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $helperAlertDetailRoute => GoRouteData.$route(
      path: '/helper-alert',
      factory: $HelperAlertDetailRouteExtension._fromState,
    );

extension $HelperAlertDetailRouteExtension on HelperAlertDetailRoute {
  static HelperAlertDetailRoute _fromState(GoRouterState state) =>
      HelperAlertDetailRoute(
        $extra: state.extra as AcceptedAlert,
      );

  String get location => GoRouteData.$location(
        '/helper-alert',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
