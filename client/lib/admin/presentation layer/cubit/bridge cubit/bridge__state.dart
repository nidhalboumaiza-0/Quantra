part of 'bridge__cubit.dart';

@immutable
sealed class BridgeState extends Equatable {}

final class BridgeInitial extends BridgeState {
  @override
  List<Object?> get props => [];
}

final class BridgeLoading extends BridgeState {
  @override
  List<Object?> get props => [];
}

final class BridgeRaiseSuccess extends BridgeState {
  @override
  List<Object?> get props => [];
}

final class BridgeCloseSuccess extends BridgeState {
  @override
  List<Object?> get props => [];
}

final class BridgeErreur extends BridgeState {
  late String message;

  BridgeErreur(this.message);

  @override
  List<Object?> get props => [message];
}

final class BridgeUnauthorized extends BridgeState {
  @override
  List<Object?> get props => [];
}

final class BridgeOffline extends BridgeState {
  late String message;

  BridgeOffline(this.message);

  @override
  List<Object?> get props => [message];
}
