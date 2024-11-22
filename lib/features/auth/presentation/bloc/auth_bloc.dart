import 'package:blog_app/core/common/cubits/auth_cubit/auth_current_user_cubit.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp
      _userSignUp; //here this field needs to be private thats why the extra methood in contructor
  final UserLogin _userLogin;
  final AuthCurrentUserCubit _authCurrentUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required AuthCurrentUserCubit authCurrentUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _authCurrentUserCubit = authCurrentUserCubit,
        super(AuthInitial()) {
          //
    on<AuthEvent>((_,emit) => AuthLoading());
    //
    on<AuthSignUpRequested>(_authSignUpRequested);

    //
    on<AuthLogInRequested>(_authLoginRequested);

    //
    on<GetCurrentUser>(_getCurrentUser);
  }

  Future<bool> _getCurrentUser(
    GetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final currentUser = auth.FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return false;
    }
    return true;
  }

  void _authSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _authLoginRequested(
      AuthLogInRequested event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _authCurrentUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
