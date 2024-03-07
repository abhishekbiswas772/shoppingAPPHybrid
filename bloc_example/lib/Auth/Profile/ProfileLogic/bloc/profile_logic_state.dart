part of 'profile_logic_bloc.dart';

sealed class ProfileLogicState extends Equatable {
  const ProfileLogicState();
  
  @override
  List<Object> get props => [];
}

final class ProfileLogicInitial extends ProfileLogicState {}
