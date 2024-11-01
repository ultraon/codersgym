import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/core/routes/app_router.gr.dart';
import 'package:myapp/features/auth/presentation/widgets/leetcode_login_button.dart';
import 'package:myapp/features/auth/presentation/widgets/typing_text_animation.dart';
import 'package:myapp/gen/assets.gen.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: TypingTextAnimation(
                  text: 'Welcome to \nDailyCoder',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ), // Use theme style for title
                ),
              ),
              SvgPicture.asset(
                Assets.icons.coding,
                width: MediaQuery.sizeOf(context).width * 0.7,
                fit: BoxFit.cover,
              ),
              Spacer(),
              LeetCodeLoginButton(),
              const SizedBox(height: 8),
              const Text("---OR---"),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).popAndPush(HomeRoute());
                },
                child: Text("Skip"),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    ));
  }
}
