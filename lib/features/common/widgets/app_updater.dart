import 'package:codersgym/core/services/github_updater.dart';
import 'package:codersgym/features/common/widgets/app_updater_dialog.dart';
import 'package:codersgym/features/settings/presentation/blocs/app_info/app_info_cubit.dart';
import 'package:codersgym/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppUpdater extends StatelessWidget {
  const AppUpdater({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final githubUpdater = getIt.get<GithubUpdater>();

    return BlocListener<AppInfoCubit, AppInfoState>(
      listener: (context, state) async {
        if (state is AppInfoLoaded) {
          // Check if we should proceed with the update check
          if (!await githubUpdater.shouldCheckForUpdate()) {
            return;
          }
          final newUpdateRelease =
              await githubUpdater.checkForUpdate(state.appVersionName);
          if (newUpdateRelease != null && context.mounted) {
            AppUpdaterDialog.show(context, releaseInfo: newUpdateRelease);
          }
        }
      },
      child: child,
    );
  }
}
