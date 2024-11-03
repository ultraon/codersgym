abstract interface class AuthService {
  Future<AuthenticationStatus> checkAuthentication();
  Future<AuthenticationStatus> loginWithLeetcodeAccount(String leetcodeSession);
  Future<AuthenticationStatus> loginWithLeetcodeUserName(
    String leetcodeUsername,
  );
  Future<AuthenticationStatus> logout();
}

sealed class AuthenticationStatus {}

class LeetcodeAccountAuthenticated extends AuthenticationStatus {
  final String leetcodeSession;
  final String userName;

  LeetcodeAccountAuthenticated({
    required this.leetcodeSession,
    required this.userName,
  });
}

class LeetcodeUsernameAuthenticated extends AuthenticationStatus {
  final String userName;

  LeetcodeUsernameAuthenticated({required this.userName});
}

class UnAuthenticatedStatus extends AuthenticationStatus {}
