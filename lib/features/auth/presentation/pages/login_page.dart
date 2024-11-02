import 'package:auto_route/auto_route.dart';
import 'package:dailycoder/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dailycoder/features/auth/presentation/widgets/username_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dailycoder/features/auth/presentation/widgets/leetcode_login_button.dart';
import 'package:dailycoder/features/auth/presentation/widgets/typing_text_animation.dart';
import 'package:dailycoder/gen/assets.gen.dart';

import '../../../../core/routes/app_router.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
        body: Center(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedWithLeetcodeAccount ||
              state is AuthenticatedWithLeetcodeUserName) {
            context.router.replace(const HomeRoute());
          }
        },
        child: SafeArea(
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: TypingTextAnimation(
                        text: 'Welcome \nTo \nDailyCoder',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ), // Use theme style for title
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.icons.coding,
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      fit: BoxFit.cover,
                    ),
                    const Spacer(),
                    LeetCodeLoginButton(),
                    const SizedBox(height: 8),
                    Text(
                      "---OR---",
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final username = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return const UsernameDialog();
                          },
                        );

                        if (username != null && username.isNotEmpty) {
                          // Use the entered username
                          print("Username entered: $username");
                        }
                      },
                      child: const Text("Enter Your UserName"),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
