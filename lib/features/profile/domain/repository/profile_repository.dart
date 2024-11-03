import 'package:dailycoder/core/error/result.dart';
import 'package:dailycoder/features/profile/domain/model/user_profile.dart';

abstract interface class ProfileRepository {
  
  Future<Result<UserProfile, Exception>> getUserProfile(String userName);
}
