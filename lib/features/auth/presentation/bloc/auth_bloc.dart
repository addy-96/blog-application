import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp
      _userSignUp; //here this fireld needs to be private thats why the extra methood in contructor
  final UserLogin _userLogin;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    //
    on<AuthSignUpRequested>(_authSignUpRequested);

    //
    on<AuthLogInRequested>(_onAuthLoginRequested);
  }

  _authSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      AuthLoading()
    );
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        AuthSuccess(
          user: r,
        ),
      ),
    );
  }

  _onAuthLoginRequested(
      AuthLogInRequested event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(
        AuthFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        AuthSuccess(
          user: r,
        ),
      ),
    );
  }
}
