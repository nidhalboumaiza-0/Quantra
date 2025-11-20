import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class DisableAccountUseCase {
  UserRepository userRepository;

  DisableAccountUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call() async {
    return await userRepository.disableMyAccount();
  }
}
