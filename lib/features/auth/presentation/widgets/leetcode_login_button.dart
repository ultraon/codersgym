import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dailycoder/core/routes/app_router.gr.dart';
import 'package:dailycoder/gen/assets.gen.dart';

class LeetCodeLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        AutoRouter.of(context).push(LeetcodeWebRoute()).then(
          (leetcodeSessionToken) {
            print(leetcodeSessionToken);
          },
        );
      },
      icon: SvgPicture.asset(
        Assets.icons.leetcode,
        height: 20,
      ),
      iconAlignment: IconAlignment.end,
      label: Text(
        'Continue with',
        style: Theme.of(context)
            .textTheme
            .bodyLarge, // Use theme style for button text
      ),
    );
  }
}
