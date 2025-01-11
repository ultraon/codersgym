import 'package:auto_route/auto_route.dart';
import 'package:codersgym/core/routes/app_router.gr.dart';
import 'package:codersgym/features/profile/presentation/pages/my_profile_page.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: AuthShell.page, children: [
          AutoRoute(page: LoginRoute.page),
          AutoRoute(page: LeetcodeWebRoute.page),
        ]),
        AutoRoute(page: DashboardShell.page, children: [
          AutoRoute(
            page: DashboardRoute.page,
            children: [
              AutoRoute(page: HomeRoute.page, initial: true),
              AutoRoute(page: ExploreRoute.page),
              AutoRoute(page: MyProfileRoute.page),
              AutoRoute(page: SettingShell.page, children: [
                AutoRoute(page: SettingRoute.page),
                AutoRoute(page: NotificationRoute.page),
              ]),
            ],
          ),
          AutoRoute(page: QuestionDetailRoute.page),
          AutoRoute(page: CodeEditorRoute.page),
          AutoRoute(page: CommunityPostRoute.page),
        ]),
      ];
}
