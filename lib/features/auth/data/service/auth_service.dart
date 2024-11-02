import 'package:dailycoder/core/utils/storage/storage_manager.dart';
import 'package:dailycoder/features/auth/domain/service/auth_service.dart';

class AuthServiceImp implements AuthService {
  final StorageManager _storageManager;

  AuthServiceImp(this._storageManager);
  @override
  Future<AuthenticationStatus> checkAuthentication() async {
    final leetcodeSession =
        await _storageManager.getString(_storageManager.leetcodeSession);
    final leetcodeUserName =
        await _storageManager.getString(_storageManager.leetcodeUserName);
    if (leetcodeSession != null) {
      return LeetcodeAccountAuthenticated(leetcodeSession: leetcodeSession);
    }
    if (leetcodeUserName != null) {
      return LeetcodeUsernameAuthenticated(userName: leetcodeUserName);
    }
    return UnAuthenticatedStatus();
  }

  @override
  Future<AuthenticationStatus> loginWithLeetcodeAccount(
      String leetcodeSession) async {
    await _storageManager.putString(
        _storageManager.leetcodeSession, leetcodeSession);
    return LeetcodeAccountAuthenticated(leetcodeSession: leetcodeSession);
  }

  @override
  Future<AuthenticationStatus> loginWithLeetcodeUserName(
      String userName) async {
    await _storageManager.putString(_storageManager.leetcodeUserName, userName);
    return LeetcodeUsernameAuthenticated(userName: userName);
  }
}

extension AuthServiceStorageExtension on StorageManager {
  String get leetcodeSession => 'leetcode_session';
  String get leetcodeUserName => 'leetcode_username';
}
