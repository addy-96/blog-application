import 'package:blog_app/core/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_current_user_state.dart';

class AuthCurrentUserCubit extends Cubit<AuthCurrentUserState> {
  AuthCurrentUserCubit() : super(AuthCurrentUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AuthCurrentUserInitial());
    } else {
      emit(AuthCurrentUserLoggedIn(user: user));
    }
  }
}
