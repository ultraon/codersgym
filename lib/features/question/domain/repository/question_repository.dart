import 'package:dailycoder/core/error/result.dart';
import 'package:dailycoder/features/question/domain/model/question.dart';

abstract interface class QuestionRepository {
  Future<Result<Question, Exception>> getTodayChallenge();
  Future<Result<Question, Exception>> getQuestionContent(
    String questiontitleSlug,
  );
}
