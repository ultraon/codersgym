import 'package:auto_route/auto_route.dart';
import 'package:dailycoder/core/routes/app_router.gr.dart';
import 'package:dailycoder/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dailycoder/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    useEffect(
      () {
        authBloc.add(AuthCheckStatus());
        return;
      },
      [],
    );

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedWithLeetcodeAccount ||
              state is AuthenticatedWithLeetcodeUserName) {
            context.router.replace(
              const DashboardRoute(),
            );
          }

          if (state is UnAuthenticated) {
            context.router.replace(
              const LoginRoute(),
            );
          }
        },
        child: Center(
          child: Image.asset(
            Assets.images.appIcon.path,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
