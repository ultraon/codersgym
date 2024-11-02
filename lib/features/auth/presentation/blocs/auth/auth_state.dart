part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

sealed class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

class AuthenticatedWithLeetcodeAccount extends Authenticated {
  final String leetcodeSession;
  AuthenticatedWithLeetcodeAccount({required this.leetcodeSession});
}

class AuthenticatedWithLeetcodeUserName extends Authenticated {
  final String userName;
  AuthenticatedWithLeetcodeUserName({required this.userName});
}
