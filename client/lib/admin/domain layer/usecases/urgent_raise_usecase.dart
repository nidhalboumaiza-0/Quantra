import 'package:dartz/dartz.dart';
import 'package:weather_app/admin/domain%20layer/repositories/admin_repository.dart';

import '../../../core/error/failures.dart';

class UrgentRaiseUsecase {
  AdminRepository adminRepository;

  UrgentRaiseUsecase({required this.adminRepository});

  Future<Either<Failure, Unit>> call(bool isRaisePont) async {
    return await adminRepository.OperationBridge(isRaisePont);
  }
}
