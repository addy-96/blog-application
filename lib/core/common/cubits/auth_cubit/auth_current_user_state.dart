part of 'auth_current_user_cubit.dart';

@immutable
sealed class AuthCurrentUserState {}

final class AuthCurrentUserInitial extends AuthCurrentUserState {}

final class AuthCurrentUserLoggedIn extends AuthCurrentUserState {
  final User user;

  AuthCurrentUserLoggedIn({
    required this.user,
  });
}
