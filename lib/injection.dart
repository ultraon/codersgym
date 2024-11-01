import 'package:get_it/get_it.dart';
import 'package:dailycoder/core/api/leetcode_api.dart';
import 'package:dailycoder/core/routes/app_router.dart';
import 'package:dailycoder/features/question/data/repository/question_repository.dart';
import 'package:dailycoder/features/question/domain/repository/question_repository.dart';
import 'package:dailycoder/features/question/presentation/blocs/daily_challenge/daily_challenge_cubit.dart';

import 'features/question/presentation/blocs/question_content/question_content_cubit.dart';

final getIt = GetIt.instance;

void intializeDependencies() {
  // ROUTER
  getIt.registerSingleton(AppRouter());

  // REPOSITORY
  final leetcodeApi = LeetcodeApi();
  getIt.registerSingleton<QuestionRepository>(
    QuestionRepositoryImpl(
      leetcodeApi: leetcodeApi,
    ),
  );

  // BLOC/CUBIT
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
