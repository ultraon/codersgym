import 'package:myapp/core/error/result.dart';
import 'package:myapp/features/question/domain/model/question.dart';

abstract interface class QuestionRepository {
  Future<Result<Question, Exception>> getTodayChallenge();
  Future<Result<Question, Exception>> getQuestionContent(
    String questiontitleSlug,
  );
}
