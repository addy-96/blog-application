part of 'get_username_bloc.dart';

@immutable
sealed class GetUsernameEvent {}

final class UsernameRequested extends GetUsernameEvent {
  final String userID;

  UsernameRequested({required this.userID});
}
