import 'package:dailycoder/core/api/leetcode_api.dart';
import 'package:dailycoder/core/utils/storage/storage_manager.dart';
import 'package:dailycoder/features/auth/data/entity/user_status_entity.dart';
import 'package:dailycoder/features/auth/domain/service/auth_service.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AuthServiceImp implements AuthService {
  final StorageManager _storageManager;
  final LeetcodeApi _leetcodeApi;

  AuthServiceImp(this._storageManager, this._leetcodeApi);
  @override
  Future<AuthenticationStatus> checkAuthentication() async {
    final leetcodeSession =
        await _storageManager.getString(_storageManager.leetcodeSession);
    final leetcodeUserName =
        await _storageManager.getString(_storageManager.leetcodeUserName);
    if (leetcodeUserName == null) {
      return UnAuthenticatedStatus();
    }
    if (leetcodeSession != null) {
      return LeetcodeAccountAuthenticated(
        leetcodeSession: leetcodeSession,
        userName: leetcodeUserName,
      );
    }
    return LeetcodeUsernameAuthenticated(userName: leetcodeUserName);
  }

  @override
  Future<AuthenticationStatus> loginWithLeetcodeAccount(
      String leetcodeSession) async {
    await _storageManager.putString(
      _storageManager.leetcodeSession,
      leetcodeSession,
    );
    final data = await _leetcodeApi.getGlobalData();
    if (data == null) {
      await logout();
      return UnAuthenticatedStatus();
    }
    final userEntity = UserStatusEntity.fromJson(data['userStatus']);
    final userName = userEntity.username;
    await _storageManager.putString(_storageManager.leetcodeUserName, userName);

    return LeetcodeAccountAuthenticated(
      leetcodeSession: leetcodeSession,
      userName: userName,
    );
  }

  @override
  Future<AuthenticationStatus> loginWithLeetcodeUserName(
      String userName) async {
    await _storageManager.putString(_storageManager.leetcodeUserName, userName);
    return LeetcodeUsernameAuthenticated(userName: userName);
  }

  @override
  Future<AuthenticationStatus> logout() async {
    await _storageManager.clearKey(_storageManager.leetcodeSession);
    await _storageManager.clearKey(_storageManager.leetcodeUserName);
    CookieManager.instance().deleteAllCookies();
    return UnAuthenticatedStatus();
  }
}

extension AuthServiceStorageExtension on StorageManager {
  String get leetcodeSession => 'leetcode_session';
  String get leetcodeUserName => 'leetcode_username';
}
