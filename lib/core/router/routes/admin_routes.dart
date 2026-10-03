import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/features/admin/presentation/screens/admin_login_screen.dart';
import 'package:sheshield/features/admin/presentation/screens/admin_queue_screen.dart';
import 'package:sheshield/features/admin/presentation/screens/admin_report_detail_screen.dart';
import 'package:sheshield/features/admin/presentation/screens/admin_verification_detail_screen.dart';
import 'package:sheshield/features/admin/presentation/screens/admin_verification_queue_screen.dart';

part 'admin_routes.g.dart';

/// Admin routes sit outside the user auth/role redirect entirely: they are
/// gated by a separate server-side key. Reached only via a long-press on
/// the login logo -- deliberately not a discoverable link.
@TypedGoRoute<AdminLoginRoute>(path: '/admin')
class AdminLoginRoute extends GoRouteData {
  const AdminLoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AdminLoginScreen();
}

@TypedGoRoute<AdminQueueRoute>(path: '/admin/reports')
class AdminQueueRoute extends GoRouteData {
  const AdminQueueRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AdminQueueScreen();
}

/// [$extra] is the report id (not the full report) so the detail screen
/// always fetches fresh data.
@TypedGoRoute<AdminReportDetailRoute>(path: '/admin/reports/detail')
class AdminReportDetailRoute extends GoRouteData {
  const AdminReportDetailRoute({required this.$extra});

  final String $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AdminReportDetailScreen(reportId: $extra);
}

@TypedGoRoute<AdminVerificationQueueRoute>(path: '/admin/verifications')
class AdminVerificationQueueRoute extends GoRouteData {
  const AdminVerificationQueueRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AdminVerificationQueueScreen();
}

@TypedGoRoute<AdminVerificationDetailRoute>(path: '/admin/verifications/detail')
class AdminVerificationDetailRoute extends GoRouteData {
  const AdminVerificationDetailRoute({required this.$extra});

  final String $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AdminVerificationDetailScreen(verificationId: $extra);
}
