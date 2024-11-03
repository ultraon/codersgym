part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthCheckStatus extends AuthEvent {}

class AuthLoginWithLeetcode extends AuthEvent {
  final String sessionId;

  const AuthLoginWithLeetcode({required this.sessionId});
  @override
  List<Object?> get props => [sessionId];
}

class AuthLoginWithLeetcodeUserName extends AuthEvent {
  final String leetcodeUserName;

  const AuthLoginWithLeetcodeUserName({required this.leetcodeUserName});
  @override
  List<Object?> get props => [leetcodeUserName];
}

class AuthLogout extends AuthEvent {}
