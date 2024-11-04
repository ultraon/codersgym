import 'package:dailycoder/core/error/result.dart';
import 'package:dailycoder/features/question/domain/model/question.dart';

abstract interface class QuestionRepository {
  Future<Result<Question, Exception>> getTodayChallenge();
  Future<Result<Question, Exception>> getQuestionContent(
    String questiontitleSlug,
  );
  Future<Result<(List<Question>, int totalQuestionCount), Exception>>
      getProblemQuestion(
    ProblemQuestionQueryInput query,
  );
}

class ProblemQuestionQueryInput {
  final String? categorySlug;
  final int? limit;
  final ProblemFilter? filters;
  final int? skip;

  ProblemQuestionQueryInput({
    this.categorySlug,
    this.limit,
    this.filters,
    this.skip,
  });
}

class ProblemFilter {
  final List<String?>? tags;
  final String? orderBy;
  final String? searchKeywords;
  final String? listId;
  final String? difficulty;

  ProblemFilter({
    this.tags,
    this.orderBy,
    this.searchKeywords,
    this.listId,
    this.difficulty,
  });
}
