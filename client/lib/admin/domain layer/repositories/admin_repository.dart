import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class AdminRepository {
  Future<Either<Failure, Unit>> OperationBridge(bool isRaisePont);
}
