import 'package:flutter/material.dart';
import 'package:dailycoder/core/routes/app_router.dart';
import 'package:dailycoder/core/theme/app_theme.dart';
import 'package:dailycoder/injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt.get<AppRouter>();
    return MaterialApp.router(
      title: 'Daily Coders',
      theme: leetcodeTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: leetcodeTheme,
      routerConfig: appRouter.config(),
    );
  }
}
