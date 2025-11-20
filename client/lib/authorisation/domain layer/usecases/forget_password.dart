import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class ForgetPasswordUseCase {
  final UserRepository userRepository;

  ForgetPasswordUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(String email) async {
    return await userRepository.forgetPassword(email);
  }
}
