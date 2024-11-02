import 'package:dailycoder/core/utils/storage/local_storage_manager.dart';
import 'package:dailycoder/core/utils/storage/storage_manager.dart';
import 'package:dailycoder/features/auth/data/service/auth_service.dart';
import 'package:dailycoder/features/auth/domain/service/auth_service.dart';
import 'package:dailycoder/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dailycoder/core/api/leetcode_api.dart';
import 'package:dailycoder/core/routes/app_router.dart';
import 'package:dailycoder/features/question/data/repository/question_repository.dart';
import 'package:dailycoder/features/question/domain/repository/question_repository.dart';
import 'package:dailycoder/features/question/presentation/blocs/daily_challenge/daily_challenge_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/question/presentation/blocs/question_content/question_content_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // UTILS
  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<StorageManager>(
    () => LocalStorageManager.getInstance(sharedPref),
  );

  // ROUTER
  getIt.registerSingleton(AppRouter());

  // SERVICE
  getIt.registerLazySingleton<AuthService>(
    () => AuthServiceImp(getIt.get()),
  );

  // REPOSITORY
  final leetcodeApi = LeetcodeApi();
  getIt.registerSingleton<QuestionRepository>(
    QuestionRepositoryImpl(
      leetcodeApi: leetcodeApi,
    ),
  );

  // BLOC/CUBIT
  getIt.registerLazySingleton(
    () => AuthBloc(
      getIt.get(),
    ),
  );
  getIt.registerLazySingleton(
    () => DailyChallengeCubit(
      getIt.get(),
    ),
  );
  getIt.registerLazySingleton(
    () => QuestionContentCubit(
      getIt.get(),
    ),
  );
}
