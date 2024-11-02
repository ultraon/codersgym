abstract interface class AuthService {
  Future<AuthenticationStatus> checkAuthentication();
  Future<AuthenticationStatus> loginWithLeetcodeAccount(String leetcodeSession);
  Future<AuthenticationStatus> loginWithLeetcodeUserName(
    String leetcodeUsername,
  );
}

sealed class AuthenticationStatus {}

class LeetcodeAccountAuthenticated extends AuthenticationStatus {
  final String leetcodeSession;

  LeetcodeAccountAuthenticated({required this.leetcodeSession});
}

class LeetcodeUsernameAuthenticated extends AuthenticationStatus {
  final String userName;

  LeetcodeUsernameAuthenticated({required this.userName});
}

class UnAuthenticatedStatus extends AuthenticationStatus {}
