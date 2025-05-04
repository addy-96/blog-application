import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements Usecase<void, NoParams> {
  final AuthRepository authRepository;
  const UserLogout({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) {
     return authRepository.logUserOut();
  }
}

class NoParams {}
