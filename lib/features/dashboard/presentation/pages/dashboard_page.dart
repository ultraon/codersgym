import 'package:auto_route/auto_route.dart';
import 'package:codersgym/core/api/api_state.dart';
import 'package:codersgym/core/routes/app_router.gr.dart';
import 'package:codersgym/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:codersgym/features/common/bloc/app_file_downloader/app_file_downloader_bloc.dart';
import 'package:codersgym/features/common/widgets/app_updater.dart';
import 'package:codersgym/features/profile/domain/model/user_profile.dart';
import 'package:codersgym/features/profile/domain/repository/profile_repository.dart';
import 'package:codersgym/features/profile/presentation/blocs/user_profile/user_profile_cubit.dart';
import 'package:codersgym/features/question/presentation/blocs/upcoming_contests/upcoming_contests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../question/presentation/blocs/daily_challenge/daily_challenge_cubit.dart';

@RoutePage()
class DashboardPage extends HookWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyChallengeCubit = context.read<DailyChallengeCubit>();
    final profileCubit = context.read<UserProfileCubit>();
    final authBloc = context.read<AuthBloc>();
    final upcomingContestCubit = context.read<UpcomingContestsCubit>();
    useEffect(
      () {
        dailyChallengeCubit.getTodayChallenge();
        upcomingContestCubit.getUpcomingContest();
        final authState = authBloc.state;
        if (authState is Authenticated) {
          profileCubit.getUserProfile(authState.userName);
        }
        final subscription = profileCubit.stream.listen(
          (profileState) {
            final currentState = profileState;
            if (currentState is ApiError<UserProfile, Exception> &&
                currentState.error is UserProfileNotFoundFailure) {
              if (context.mounted) {
                showUserNotFoundDialog(context);
              }
            }
          },
        );
        return subscription.cancel;
      },
      [],
    );

    return AppUpdater(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            context.router.root.pushAndPopUntil(
              const LoginRoute(),
              predicate: (route) => false,
            );
          }
        },
        child: BlocListener<AppFileDownloaderBloc, AppFileDownloaderState>(
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);
            if (state is AppFileIntiatingDownload) {
              messenger.showSnackBar(
                const SnackBar(
                  content: Text(
                    "Exciting updates are on the way!",
                  ),
                ),
              );
            }
          },
          child: AutoTabsRouter.pageView(
            routes: const [
              HomeRoute(),
              ExploreRoute(),
              MyProfileRoute(),
              SettingRoute(),
            ],
            builder: (context, child, _) {
              final tabsRouter = AutoTabsRouter.of(context);
              return Scaffold(
                body: child,
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex, // Update selected index
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore_rounded),
                      label: 'Explore',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void showUserNotFoundDialog(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            if (context.mounted) {
              authBloc.add(AuthLogout());
            }
          },
        );

        return const AlertDialog(
          title: Text("User Not Found"),
          content: Text(
            "Redirecting to the login page...",
          ),
        );
      },
    );
  }
}
