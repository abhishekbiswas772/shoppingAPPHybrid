part of 'home_logic_bloc.dart';

@immutable
sealed class HomeLogicEvent extends Equatable {
  const HomeLogicEvent();
  @override
  List<Object> get props => [];
}

class HomePageCallerEvent extends HomeLogicEvent {}

class HomePageSpeechEvent extends HomeLogicEvent {}
