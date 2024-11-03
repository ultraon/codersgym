import 'package:auto_route/auto_route.dart';
import 'package:dailycoder/core/routes/app_router.gr.dart';
import 'package:dailycoder/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dailycoder/features/auth/presentation/pages/login_page.dart';
import 'package:dailycoder/features/profile/presentation/blocs/user_profile/user_profile_cubit.dart';
import 'package:dailycoder/features/profile/presentation/pages/my_profile_page.dart';
import 'package:dailycoder/features/question/presentation/pages/home_page.dart';
import 'package:dailycoder/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../question/presentation/blocs/daily_challenge/daily_challenge_cubit.dart';

@RoutePage()
class DashboardPage extends HookWidget implements AutoRouteWrapper {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyChallengeCubit = context.read<DailyChallengeCubit>();
    final profileCubit = context.read<UserProfileCubit>();
    final authBloc = context.read<AuthBloc>();
    useEffect(
      () {
        dailyChallengeCubit.getTodayChallenge();
        final authState = authBloc.state;
        if (authState is Authenticated) {
          profileCubit.getUserProfile(authState.userName);
        }
        return null;
      },
      [],
    );
    useEffect(() {
      return;
    }, []);

    final currentIndex = useState(0);
    final pages = [
      BlocProvider.value(
        value: dailyChallengeCubit,
        child: const HomePage(),
      ),
      const Center(child: Text('Search')),
      const MyProfilePage(),
    ];

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            context.router.pushAndPopUntil(
              const LoginRoute(),
              predicate: (route) => false,
            );
          }
        },
        child: pages[currentIndex.value],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) => currentIndex.value = index, // Update selected index
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
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<DailyChallengeCubit>(),
      child: this,
    );
  }
}
