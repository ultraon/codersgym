import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myapp/features/common/presentation/widgets/app_webview.dart';

@RoutePage()
class LeetcodeWebPage extends StatelessWidget {
  const LeetcodeWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppWebview(
      url: "https://leetcode.com/accounts/login/",
      redirectUrl: "https://leetcode.com/",
      onUrlRedirection: () async {
        final cookieManager = CookieManager.instance();
        final loginCookie = await cookieManager.getCookie(
          url: WebUri("https://leetcode.com"),
          name: "LEETCODE_SESSION",
        );
        if (context.mounted) {
          AutoRouter.of(context).maybePop(loginCookie?.value);
        }
      },
    );
  }
}
