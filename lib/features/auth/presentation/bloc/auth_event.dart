part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthSignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpRequested(
      {required this.name, required this.email, required this.password});
}

final class AuthLogInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLogInRequested({required this.email, required this.password});
}

final class AuthLogoutRequested extends AuthEvent{}

final class GetCurrentUser extends AuthEvent {}

final class AuthLogOutRequested extends AuthEvent {}
