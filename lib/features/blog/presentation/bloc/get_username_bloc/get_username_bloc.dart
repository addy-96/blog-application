import 'package:blog_app/features/blog/domain/usecases/get_username.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_username_event.dart';
part 'get_username_state.dart';

class GetUsernameBloc extends Bloc<GetUsernameEvent, GetUsernameState> {
  final GetUsername getUsername;

  GetUsernameBloc({required this.getUsername}) : super(GetUsernameInitial()) {
    on<UsernameRequested>(_onUsernameRequested);
  }

  void _onUsernameRequested(
      UsernameRequested event, Emitter<GetUsernameState> emit) async {
    emit(GetUsernameLoading());

    final res = await getUsername.call(GetUserNameParams(userID: event.userID));

    res.fold(
      (l) => emit(GetUsernameFailure()),
      (r) => emit(GetUsernameSuccess(username: r)),
    );
  }
}
