import 'package:dailycoder/core/api/leetcode_api.dart';
import 'package:dailycoder/core/error/result.dart';
import 'package:dailycoder/features/profile/data/entity/user_profile_entity.dart';
import 'package:dailycoder/features/profile/domain/model/user_profile.dart';
import 'package:dailycoder/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final LeetcodeApi _leetcodeApi;

  ProfileRepositoryImp(this._leetcodeApi);
  @override
  Future<Result<UserProfile, Exception>> getUserProfile(String userName) async {
    final data = await _leetcodeApi.getUserProfile(userName);
    if (data == null) {
      return Failure(Exception("Not user profile data found"));
    }
    final userProfile = UserProfileEntity.fromJson(data);
    return Success(userProfile.toUserProfile());
  }
}
