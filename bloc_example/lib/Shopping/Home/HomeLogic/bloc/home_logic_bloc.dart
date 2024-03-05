import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_logic_event.dart';
part 'home_logic_state.dart';

class HomeLogicBloc extends Bloc<HomeLogicEvent, HomeLogicState> {
  HomeLogicBloc() : super(HomeLogicInitial()) {
    on<HomeLogicEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
