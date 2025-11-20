import 'package:dartz/dartz.dart';
import 'package:weather_app/admin/domain%20layer/repositories/admin_repository.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../data sources/admin_remote_data_source.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource adminRemoteDataSource;

  final NetworkInfo networkInfo;

  AdminRepositoryImpl({
    required this.adminRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> OperationBridge(bool isRaisePont) async {
    if (await networkInfo.isConnected) {
      try {
        await adminRemoteDataSource.OperationBridge(isRaisePont);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
