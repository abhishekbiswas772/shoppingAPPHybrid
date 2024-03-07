part of 'details_logic_bloc.dart';

@immutable
sealed class DetailsLogicEvent extends Equatable {
  const DetailsLogicEvent();

  @override
  List<Object> get props => [];
}

class HomeDetailsInitEvent extends DetailsLogicEvent {}

class HomeProductDetailsEvent extends DetailsLogicEvent {
  final int productId;
  const HomeProductDetailsEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class HomeDetailsResetInitEvent extends DetailsLogicEvent {}
