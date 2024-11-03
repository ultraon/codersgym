import 'package:bloc/bloc.dart';
import 'package:dailycoder/core/api/api_state.dart';
import 'package:dailycoder/features/profile/domain/model/user_profile.dart';
import 'package:dailycoder/features/profile/domain/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';

class UserProfileCubit extends Cubit<ApiState<UserProfile, Exception>> {
  UserProfileCubit(this._profileRepository) : super(ApiState.initial());
  final ProfileRepository _profileRepository;

  Future<void> getUserProfile(String userName) async {
    emit(ApiLoading());
    final result = await _profileRepository.getUserProfile(userName);
    result.when(
      onSuccess: (profile) {
        emit(ApiLoaded(profile));
      },
      onFailure: (exception) {
        emit(ApiError(exception));
      },
    );
  }
}
