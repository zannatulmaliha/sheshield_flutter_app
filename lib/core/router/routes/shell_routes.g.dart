// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shell_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $rootShellRouteData,
    ];

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
