// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $loginRoute,
      $signupRoute,
      $verificationRoute,
      $sosSentRoute,
      $notificationsRoute,
      $helperAlertDetailRoute,
      $rootShellRouteData,
    ];

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupRoute => GoRouteData.$route(
      path: '/signup',
      factory: $SignupRouteExtension._fromState,
    );

extension $SignupRouteExtension on SignupRoute {
  static SignupRoute _fromState(GoRouterState state) => const SignupRoute();

  String get location => GoRouteData.$location(
        '/signup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $verificationRoute => GoRouteData.$route(
      path: '/verification',
      factory: $VerificationRouteExtension._fromState,
    );

extension $VerificationRouteExtension on VerificationRoute {
  static VerificationRoute _fromState(GoRouterState state) =>
      const VerificationRoute();

  String get location => GoRouteData.$location(
        '/verification',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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

RouteBase get $rootShellRouteData => ShellRouteData.$route(
      factory: $RootShellRouteDataExtension._fromState,
      routes: [
        StatefulShellRouteData.$route(
          factory: $UserShellRouteDataExtension._fromState,
          branches: [
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/home/user',
                  factory: $UserHomeRouteExtension._fromState,
                ),
              ],
            ),
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/home/user/contacts',
                  factory: $UserContactsRouteExtension._fromState,
                ),
              ],
            ),
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/home/user/ai',
                  factory: $UserAiRouteExtension._fromState,
                ),
              ],
            ),
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/home/user/profile',
                  factory: $UserProfileRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellRouteData.$route(
          factory: $HelperShellRouteDataExtension._fromState,
          branches: [
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/home/helper',
                  factory: $HelperDashboardRouteExtension._fromState,
                ),
              ],
            ),
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/home/helper/history',
                  factory: $HelperHistoryRouteExtension._fromState,
                ),
              ],
            ),
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/home/helper/profile',
                  factory: $HelperProfileRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $RootShellRouteDataExtension on RootShellRouteData {
  static RootShellRouteData _fromState(GoRouterState state) =>
      const RootShellRouteData();
}

extension $UserShellRouteDataExtension on UserShellRouteData {
  static UserShellRouteData _fromState(GoRouterState state) =>
      const UserShellRouteData();
}

extension $UserHomeRouteExtension on UserHomeRoute {
  static UserHomeRoute _fromState(GoRouterState state) => const UserHomeRoute();

  String get location => GoRouteData.$location(
        '/home/user',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserContactsRouteExtension on UserContactsRoute {
  static UserContactsRoute _fromState(GoRouterState state) =>
      const UserContactsRoute();

  String get location => GoRouteData.$location(
        '/home/user/contacts',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserAiRouteExtension on UserAiRoute {
  static UserAiRoute _fromState(GoRouterState state) => const UserAiRoute();

  String get location => GoRouteData.$location(
        '/home/user/ai',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserProfileRouteExtension on UserProfileRoute {
  static UserProfileRoute _fromState(GoRouterState state) =>
      const UserProfileRoute();

  String get location => GoRouteData.$location(
        '/home/user/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HelperShellRouteDataExtension on HelperShellRouteData {
  static HelperShellRouteData _fromState(GoRouterState state) =>
      const HelperShellRouteData();
}

extension $HelperDashboardRouteExtension on HelperDashboardRoute {
  static HelperDashboardRoute _fromState(GoRouterState state) =>
      const HelperDashboardRoute();

  String get location => GoRouteData.$location(
        '/home/helper',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HelperHistoryRouteExtension on HelperHistoryRoute {
  static HelperHistoryRoute _fromState(GoRouterState state) =>
      const HelperHistoryRoute();

  String get location => GoRouteData.$location(
        '/home/helper/history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HelperProfileRouteExtension on HelperProfileRoute {
  static HelperProfileRoute _fromState(GoRouterState state) =>
      const HelperProfileRoute();

  String get location => GoRouteData.$location(
        '/home/helper/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
