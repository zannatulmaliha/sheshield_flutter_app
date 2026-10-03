// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $adminLoginRoute,
      $adminQueueRoute,
      $adminReportDetailRoute,
      $adminVerificationQueueRoute,
      $adminVerificationDetailRoute,
    ];

RouteBase get $adminLoginRoute => GoRouteData.$route(
      path: '/admin',
      factory: $AdminLoginRouteExtension._fromState,
    );

extension $AdminLoginRouteExtension on AdminLoginRoute {
  static AdminLoginRoute _fromState(GoRouterState state) =>
      const AdminLoginRoute();

  String get location => GoRouteData.$location(
        '/admin',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminQueueRoute => GoRouteData.$route(
      path: '/admin/reports',
      factory: $AdminQueueRouteExtension._fromState,
    );

extension $AdminQueueRouteExtension on AdminQueueRoute {
  static AdminQueueRoute _fromState(GoRouterState state) =>
      const AdminQueueRoute();

  String get location => GoRouteData.$location(
        '/admin/reports',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminReportDetailRoute => GoRouteData.$route(
      path: '/admin/reports/detail',
      factory: $AdminReportDetailRouteExtension._fromState,
    );

extension $AdminReportDetailRouteExtension on AdminReportDetailRoute {
  static AdminReportDetailRoute _fromState(GoRouterState state) =>
      AdminReportDetailRoute(
        $extra: state.extra as String,
      );

  String get location => GoRouteData.$location(
        '/admin/reports/detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $adminVerificationQueueRoute => GoRouteData.$route(
      path: '/admin/verifications',
      factory: $AdminVerificationQueueRouteExtension._fromState,
    );

extension $AdminVerificationQueueRouteExtension on AdminVerificationQueueRoute {
  static AdminVerificationQueueRoute _fromState(GoRouterState state) =>
      const AdminVerificationQueueRoute();

  String get location => GoRouteData.$location(
        '/admin/verifications',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminVerificationDetailRoute => GoRouteData.$route(
      path: '/admin/verifications/detail',
      factory: $AdminVerificationDetailRouteExtension._fromState,
    );

extension $AdminVerificationDetailRouteExtension
    on AdminVerificationDetailRoute {
  static AdminVerificationDetailRoute _fromState(GoRouterState state) =>
      AdminVerificationDetailRoute(
        $extra: state.extra as String,
      );

  String get location => GoRouteData.$location(
        '/admin/verifications/detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
