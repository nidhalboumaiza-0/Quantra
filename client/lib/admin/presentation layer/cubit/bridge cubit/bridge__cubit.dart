import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../domain layer/usecases/urgent_raise_usecase.dart';

part 'bridge__state.dart';

class BridgeCubit extends Cubit<BridgeState> {
  UrgentRaiseUsecase urgentRaiseUsecase;

  BridgeCubit({required this.urgentRaiseUsecase}) : super(BridgeInitial());

  void operationBridge(bool isRaisePont) async {
    emit(BridgeLoading());
    final result = await urgentRaiseUsecase(isRaisePont);
    result.fold((failure) {
      if (failure is ServerFailure) {
        emit(BridgeErreur('Server Failure'));
      } else if (failure is ServerMessageFailure) {
        emit(BridgeErreur('Server Message Failure'));
      } else if (failure is UnauthorizedFailure) {
        emit(BridgeUnauthorized());
      } else if (failure is OfflineFailure) {
        emit(BridgeOffline('Offline Failure'));
      }
    }, (_) {
      if (isRaisePont) {
        emit(BridgeRaiseSuccess());
      } else {
        emit(BridgeCloseSuccess());
      }
    });
  }
}
