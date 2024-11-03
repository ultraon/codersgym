import 'package:auto_route/auto_route.dart';
import 'package:dailycoder/core/routes/app_router.gr.dart';
import 'package:dailycoder/core/utils/app_constants.dart';
import 'package:dailycoder/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dailycoder/features/profile/presentation/blocs/user_profile/user_profile_cubit.dart';
import 'package:dailycoder/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    final profileCubit = context.read<UserProfileCubit>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final userName =
                  (authState is Authenticated) ? authState.userName : null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: theme.focusColor,
                          child: CircleAvatar(
                            foregroundImage:
                                AssetImage(Assets.images.appIcon.path),
                            radius: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "DailyCoder",
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: theme.primaryColor,
                    ),
                    title: const Text("Notifications"),
                    onTap: () {
                      AutoRouter.of(context).push(const NotificationRoute());
                    },
                  ),
                  // Report Bug Section
                  ListTile(
                    leading: Icon(
                      Icons.bug_report,
                      color: theme.primaryColor,
                    ),
                    title: const Text("Report a Bug"),
                    onTap: () {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: AppConstants.reportBugEmail,
                        queryParameters: {
                          'subject': 'Bug Report from ${userName}',
                          'body': 'Please describe the issue here...',
                        },
                      );
                      _launchUrl(emailUri);
                    },
                  ),

                  // Source Code Section
                  ListTile(
                    leading: Icon(
                      Icons.code,
                      color: theme.primaryColor,
                    ),
                    title: const Text("Source Code"),
                    onTap: () {
                      final uri = Uri.tryParse(AppConstants.sourceCodeUrl);
                      if (uri != null) _launchUrl(uri);
                    },
                  ),

                  // About Section
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: theme.primaryColor,
                    ),
                    title: const Text("About"),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: "DailyCoder",
                        applicationVersion: "1.0.0",
                        applicationIcon: Image.asset(
                          Assets.images.appIcon.path,
                          width: 60,
                          height: 60,
                        ),
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                                "This app is used to view leetcode problem in mobile friendly view."),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Currntly Logged as:",
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        if (authState is AuthenticatedWithLeetcodeAccount)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${userName}",
                                style: textTheme.bodyLarge,
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.verified,
                                color: theme.primaryColor,
                                size: 20,
                              ),
                            ],
                          ),
                        if (authState is AuthenticatedWithLeetcodeUserName)
                          Text(
                            "Guest User : ${userName}",
                            style: textTheme.bodyLarge,
                          ),
                      ],
                    ),
                  ),

                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogout());
                      },
                      label: const Text("Logout"),
                      icon: const Icon(Icons.logout_rounded),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
