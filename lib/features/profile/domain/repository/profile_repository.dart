import 'package:dailycoder/core/error/result.dart';
import 'package:dailycoder/features/profile/domain/model/contest_ranking_info.dart';
import 'package:dailycoder/features/profile/domain/model/user_profile.dart';
import 'package:dailycoder/features/profile/domain/model/user_profile_calendar.dart';

abstract interface class ProfileRepository {
  Future<Result<UserProfile, UserProfileFailure>> getUserProfile(
    String userName,
  );
  Future<Result<ContestRankingInfo, Exception>> getContestRankingInfo(
    String userName,
  );
  Future<Result<UserProfileCalendar, Exception>> getUserProfileCalendar(
    String userName,
  );
}

class UserProfileFailure implements Exception {}

class UserProfileNotFoundFailure implements UserProfileFailure {}
