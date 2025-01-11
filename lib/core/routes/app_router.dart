import 'package:auto_route/auto_route.dart';
import 'package:codersgym/core/routes/app_router.gr.dart';
import 'package:codersgym/features/profile/presentation/pages/my_profile_page.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: SplashRoute.page),
        AutoRoute(
          path: '/dashboard',
          page: DashboardRoute.page,
          children: [
            AutoRoute(path: '', page: HomeRoute.page, initial: true),
            AutoRoute(path: 'explore', page: ExploreRoute.page),
            AutoRoute(path: 'my_profile', page: MyProfileRoute.page),
            AutoRoute(path: 'settings', page: SettingRoute.page),
          ],
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: QuestionDetailRoute.page),
        AutoRoute(page: LeetcodeWebRoute.page),
        AutoRoute(page: NotificationRoute.page),
        AutoRoute(page: CommunityPostRoute.page),
        AutoRoute(page: CodeEditorRoute.page),
      ];
}
