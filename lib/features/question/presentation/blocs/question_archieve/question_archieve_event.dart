part of 'question_archieve_bloc.dart';

sealed class QuestionArchieveEvent extends Equatable {
  const QuestionArchieveEvent();
}

class FetchQuestionsListEvent extends QuestionArchieveEvent {
  final int? skip;
  final int? limit;
  final String? categorySlug;

  const FetchQuestionsListEvent({
    this.limit,
    this.skip,
    this.categorySlug,
  });

  @override
  List<Object?> get props => [skip, limit];
}
