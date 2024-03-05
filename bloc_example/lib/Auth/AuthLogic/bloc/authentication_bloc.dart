import 'package:bloc/bloc.dart';
import 'package:bloc_example/Auth/AuthModel/auth_model.dart';
import 'package:bloc_example/Auth/AuthRepo/auth_repo.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo authRepo = AuthRepo();
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthCreateUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final AuthModel? authModel =
            await authRepo.createUserFirebase(event.mail, event.password);
        if (authModel != null) {
          emit(AuthenticationSuccessState(authModel));
        } else {
          emit(const AuthenticationFailureState("Error in creating User"));
        }
      } catch (e) {
        // print(e.toString());
        emit(const AuthenticationFailureState("Error in creating User"));
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });

    on<AuthSignInUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final AuthModel? authModel =
            await authRepo.preformSignInUser(event.mail, event.password);
        if (authModel != null) {
          emit(AuthenticationSuccessState(authModel));
        } else {
          emit(const AuthenticationFailureState("Failed to SignIn User"));
        }
      } catch (e) {
        // print(e.toString());
        emit(const AuthenticationFailureState("Failed to SignIn User"));
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });

    on<AuthSignOutUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        await authRepo.preformSignOutUser();
      } catch (e) {
        emit(const AuthenticationFailureState("Failed to SignOut User"));
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });

    on<AuthEmailReset>((event, emit) async {
      emit(const AuthenticationEmailLoading(isLoading: true));
      bool resultFromFirebase =
          await authRepo.getResetPasswordLink(event.mail.trim());
      if (resultFromFirebase) {
        emit(AuthenticationEmailSuccessEvent());
      } else {
        emit(const AuthenticationEmailFailureEvent(
            "Failed To generate Link For password reset"));
      }
      emit(const AuthenticationEmailLoading(isLoading: false));
    });
  }
}
