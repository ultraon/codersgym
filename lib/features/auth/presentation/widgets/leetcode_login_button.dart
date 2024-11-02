import 'package:auto_route/auto_route.dart';
import 'package:dailycoder/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dailycoder/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dailycoder/core/routes/app_router.gr.dart';
import 'package:dailycoder/gen/assets.gen.dart';

class LeetCodeLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        final authbloc = context.read<AuthBloc>();
        AutoRouter.of(context).push(const LeetcodeWebRoute()).then(
          (leetcodeSessionToken) {
            if (leetcodeSessionToken is String) {
              authbloc
                  .add(AuthLoginWithLeetcode(sessionId: leetcodeSessionToken));
            }
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
