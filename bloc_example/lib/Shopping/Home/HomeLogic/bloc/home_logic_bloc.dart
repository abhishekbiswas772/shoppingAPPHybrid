import 'package:bloc/bloc.dart';
import 'package:bloc_example/Auth/AuthModel/auth_model.dart';
import 'package:bloc_example/Auth/AuthRepo/auth_repo.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model.dart';
import 'package:bloc_example/Shopping/Home/HomeRepo/home_repo.dart';
import 'package:bloc_example/Utils/Location/location_address.dart';
import 'package:bloc_example/Utils/speech/speech_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_logic_event.dart';
part 'home_logic_state.dart';

class HomeLogicBloc extends Bloc<HomeLogicEvent, HomeLogicState> {
  final LocationAddress address = LocationAddress();
  final HomeRepo homeRepo = HomeRepo();
  final AuthRepo authRepo = AuthRepo();
  final SpeechService speechService = SpeechService();

  HomeLogicBloc() : super(HomeLogicInitial()) {
    on<HomeLogicEvent>((event, emit) {});
    on<HomePageCallerEvent>((event, emit) async {
      emit(HomeLogicLoading());
      try {
        AuthModel? model;
        authRepo.getCurrentUser((p0) async {
          model = p0;
        });
        final HomeModel? homeModel = await homeRepo.getProductAndCategory();
        String? locString = await address.getLocationAddress(); 
        if ((homeModel != null) && (model != null)) {
          emit(HomeLogicSuccess(homeModel, model!, locString ?? ""));
        } else {
          emit(const HomeLogicFailure("Home Model failed from API response"));
        }
      } catch (e) {
        print(e.toString());
        emit(const HomeLogicFailure("Error in Calling the API"));
      }
    });
    on<HomePageSpeechEvent>((event, emit) {
      emit(HomeSpeechLoading());
      try {
        String recognizedString = "";
        speechService.initSpeechServiceAndRecognize((p0) {
          if (p0 != null) {
            recognizedString = p0;
          }
        });
        if (recognizedString.isEmpty) {
          emit(const HomeSpeechFailure("Error in Recognition"));
        } else {
          emit(HomeSpeechSuccess(recognizedString));
        }
      } catch (_) {
        emit(const HomeSpeechFailure("Error in Recognition"));
      }
    });
  }
}
