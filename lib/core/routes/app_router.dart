import 'package:auto_route/auto_route.dart';
import 'package:myapp/core/routes/app_router.gr.dart';
import 'package:myapp/features/auth/presentation/pages/leetcode_web_page.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: QuestionDetailRoute.page),
        AutoRoute(page: LeetcodeWebRoute.page),
      ];
}
