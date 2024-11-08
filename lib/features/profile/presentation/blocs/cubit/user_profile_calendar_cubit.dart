import 'package:bloc/bloc.dart';
import 'package:codersgym/core/api/api_state.dart';
import 'package:codersgym/features/profile/domain/model/user_profile_calendar.dart';
import 'package:codersgym/features/profile/domain/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';

class UserProfileCalendarCubit
    extends Cubit<ApiState<UserProfileCalendar, Exception>> {
  UserProfileCalendarCubit(this._profileRepository) : super(ApiState.initial());
  final ProfileRepository _profileRepository;

  Future<void> getUserProfileSubmissionCalendar(String userName) async {
    emit(ApiLoading());
    final result = await _profileRepository.getUserProfileCalendar(userName);
    result.when(
      onSuccess: (profileCalendar) {
        emit(
          ApiLoaded(
            profileCalendar,
          ),
        );
      },
      onFailure: (exception) => emit(
        ApiError(exception),
      ),
    );
  }
}
