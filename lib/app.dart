import 'package:dailycoder/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dailycoder/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:dailycoder/core/routes/app_router.dart';
import 'package:dailycoder/core/theme/app_theme.dart';
import 'package:dailycoder/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppInitializer extends HookWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    final isInitialized = useState(false);

    useEffect(() {
      Future<void> initialize() async {
        await initializeDependencies();
        isInitialized.value = true;
      }

      initialize();
      return null;
    }, []);

    if (!isInitialized.value) {
      return WidgetsApp(
        color: leetcodeTheme.scaffoldBackgroundColor,
        builder: (context, _) => Scaffold(
          body: Center(
            child: Image.asset(
              Assets.images.appIcon.path,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
    }

    // Once initialized, show the main MaterialApp
    return const App();
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt.get<AppRouter>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Daily Coders',
        theme: leetcodeTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: leetcodeTheme,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
