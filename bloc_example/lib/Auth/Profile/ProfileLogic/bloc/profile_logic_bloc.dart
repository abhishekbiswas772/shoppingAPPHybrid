import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_logic_event.dart';
part 'profile_logic_state.dart';

class ProfileLogicBloc extends Bloc<ProfileLogicEvent, ProfileLogicState> {
  ProfileLogicBloc() : super(ProfileLogicInitial()) {
    on<ProfileLogicEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
