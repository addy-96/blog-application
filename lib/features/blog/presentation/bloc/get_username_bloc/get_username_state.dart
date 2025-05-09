part of 'get_username_bloc.dart';

@immutable
sealed class GetUsernameState {}

final class GetUsernameInitial extends GetUsernameState {}

final class GetUsernameLoading extends GetUsernameState {}

final class GetUsernameSuccess extends GetUsernameState {
  GetUsernameSuccess({
    required this.username,
  });
  final String username;
}

final class GetUsernameFailure extends GetUsernameState {
  final String errorMesssage;
  GetUsernameFailure({
    required this.errorMesssage,
  });
}
