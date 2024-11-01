import 'package:myapp/core/error/result.dart';
import 'package:myapp/core/api/leetcode_api.dart';
import 'package:myapp/features/question/data/entity/daily_question_entity.dart';
import 'package:myapp/features/question/data/entity/question_entity.dart';
import 'package:myapp/features/question/domain/model/question.dart';
import 'package:myapp/features/question/domain/repository/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final LeetcodeApi leetcodeApi;

  QuestionRepositoryImpl({required this.leetcodeApi});
  @override
  Future<Result<Question, Exception>> getTodayChallenge() async {
    final data = await leetcodeApi.getDailyQuestion();
    if (data == null) {
      return Failure(Exception("No data found"));
    }
    final question = DailyQuestionEntity.fromJson(data);

    return Success(question.toQuestion());
  }

  @override
  Future<Result<Question, Exception>> getQuestionContent(
      String questiontitleSlug) async {
    final data = await leetcodeApi.getQuestionContent(questiontitleSlug);
    if (data == null) {
      return Failure(Exception("No data found"));
    }
    final question = QuestionNodeEntity.fromJson(data['question']);

    return Success(question.toQuestion());
  }
}
