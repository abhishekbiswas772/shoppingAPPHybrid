part of 'home_logic_bloc.dart';

@immutable
sealed class HomeLogicState extends Equatable {
  const HomeLogicState();
  @override
  List<Object> get props => [];
}

final class HomeLogicInitial extends HomeLogicState {}

class HomeLogicLoading extends HomeLogicState {}

class HomeLogicSuccess extends HomeLogicState {
  final HomeModel modelHome;
  final AuthModel authModel;
  final String locationString;
  const HomeLogicSuccess(this.modelHome, this.authModel, this.locationString);

  @override
  List<Object> get props => [modelHome];
}

class HomeLogicFailure extends HomeLogicState {
  final String errorMessage;
  const HomeLogicFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class HomeSpeechSuccess extends HomeLogicState {
  final String recognizedString;
  const HomeSpeechSuccess(this.recognizedString);

  @override
  List<Object> get props => [recognizedString];
}

class HomeSpeechLoading extends HomeLogicState {}
class HomeSpeechFailure extends HomeLogicState {
  final String error;
  const HomeSpeechFailure(this.error);

  @override
  List<Object> get props => [error];
}
