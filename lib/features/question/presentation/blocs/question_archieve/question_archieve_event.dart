part of 'question_archieve_bloc.dart';

sealed class QuestionArchieveEvent extends Equatable {
  const QuestionArchieveEvent();
}

class FetchQuestionsListEvent extends QuestionArchieveEvent {
  /// Pass skip : 0 for reseting the list to start from the begining
  /// otherwise it add the search result in the current list only
  final int? skip;
  final int? limit;
  final String? categorySlug;
  final String? searchKeyword;

  const FetchQuestionsListEvent({
    this.limit,
    this.skip,
    this.categorySlug,
    this.searchKeyword,
  });

  @override
  List<Object?> get props => [skip, limit];
}
