import 'package:bloc/bloc.dart';
import 'package:dailycoder/core/api/api_state.dart';
import 'package:dailycoder/features/question/domain/model/contest.dart';
import 'package:dailycoder/features/question/domain/repository/question_repository.dart';

class UpcomingContestsCubit extends Cubit<ApiState<List<Contest>, Exception>> {
  final QuestionRepository _questionRepository;
  UpcomingContestsCubit(this._questionRepository) : super(ApiState.initial());

  Future<void> getUpcomingContest() async {
    emit(ApiLoading());
    final result = await _questionRepository.getUpcomingContests();
    result.when(
      onSuccess: (contests) {
        emit(ApiLoaded(contests));
      },
      onFailure: (exception) {
        emit(ApiError(exception));
      },
    );
  }
}
