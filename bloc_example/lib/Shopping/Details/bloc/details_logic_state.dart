part of 'details_logic_bloc.dart';

@immutable
sealed class DetailsLogicState extends Equatable {
  const DetailsLogicState();

  @override
  List<Object> get props => [];
}

class DetailsLogicInitial extends DetailsLogicState {}

class DetailsLogicLoading extends DetailsLogicState {}

class DetailsLogicSuccess extends DetailsLogicState {}

class DetailsLogicFailure extends DetailsLogicState {
  final String errorString;
  const DetailsLogicFailure(this.errorString);

  @override
  List<Object> get props => [errorString];
}
