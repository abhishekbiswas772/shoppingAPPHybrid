import 'package:bloc/bloc.dart';
import 'package:bloc_example/Shopping/Details/DetailsRepo/details_repo.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'details_logic_event.dart';
part 'details_logic_state.dart';

class DetailsLogicBloc extends Bloc<DetailsLogicEvent, DetailsLogicState> {
  final DetailsRepo _detailsRepo = DetailsRepo();

  DetailsLogicBloc() : super(DetailsLogicInit()) {
    on<HomeDetailsInitEvent>((event, emit) {
      emit(DetailLogicInitReset());
    });
    on<HomeProductDetailsEvent>((event, emit) async {
      emit(DetailsLogicLoading());
      try {
        HomeAllProductModel? model =
            await _detailsRepo.getSingleModel(event.productId);
        if (model != null) {
          emit(DetailsLogicSuccess(model));
        } else {
          emit(const DetailsLogicFailure("Fail to call Details API"));
        }
      } catch (_) {
        emit(const DetailsLogicFailure("Fail to call Details API"));
      }
    });
  }
}
