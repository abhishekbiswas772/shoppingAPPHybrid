import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'details_logic_event.dart';
part 'details_logic_state.dart';

class DetailsLogicBloc extends Bloc<DetailsLogicEvent, DetailsLogicState> {
  DetailsLogicBloc() : super(DetailsLogicInitial()) {
    on<DetailsLogicEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
