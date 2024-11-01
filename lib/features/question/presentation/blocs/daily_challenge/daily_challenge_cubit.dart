import 'package:bloc/bloc.dart';
import 'package:myapp/core/api/api_state.dart';
import 'package:myapp/features/question/domain/model/question.dart';
import 'package:myapp/features/question/domain/repository/question_repository.dart';

class DailyChallengeCubit extends Cubit<ApiState<Question, Exception>> {
  DailyChallengeCubit(this._questionRepository)
      : super(ApiState<Question, Exception>.initial());
  final QuestionRepository _questionRepository;
  Future<void> getTodayChallenge() async {
    emit(ApiLoading());
    final result = await _questionRepository.getTodayChallenge();
    result.when(
      onSuccess: (value) {
        emit(ApiLoaded(value));
      },
      onFailure: (exception) {
        emit(ApiError(exception));
      },
    );
  }
}
