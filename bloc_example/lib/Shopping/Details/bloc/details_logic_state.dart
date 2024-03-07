part of 'details_logic_bloc.dart';

@immutable
sealed class DetailsLogicState extends Equatable {
  const DetailsLogicState();

  @override
  List<Object> get props => [];
}

class DetailsLogicInit extends DetailsLogicState {}
class DetailLogicInitReset extends DetailsLogicState {}
class DetailsLogicLoading extends DetailsLogicState {}

class DetailsLogicSuccess extends DetailsLogicState {
  final HomeAllProductModel model;
  const DetailsLogicSuccess(this.model);
}

class DetailsLogicFailure extends DetailsLogicState {
  final String errorString;
  const DetailsLogicFailure(this.errorString);

  @override
  List<Object> get props => [errorString];
}
