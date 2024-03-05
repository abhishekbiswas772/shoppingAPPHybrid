part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

// Define Diffent State Possibly Happens in Auth Process using firebase
// For loading
class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;
  const AuthenticationLoadingState({required this.isLoading});
}

// For Auth Success Event
class AuthenticationSuccessState extends AuthenticationState {
  final AuthModel firebaseUser;
  const AuthenticationSuccessState(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser];
}

// For Auth Failure Event
class AuthenticationFailureState extends AuthenticationState {
  final String errorString;
  const AuthenticationFailureState(this.errorString);

  @override
  List<Object> get props => [errorString];
}

class AuthenticationEmailSuccessEvent extends AuthenticationState {}

class AuthenticationEmailFailureEvent extends AuthenticationState {
  final String errorString;
  const AuthenticationEmailFailureEvent(this.errorString);
  @override
  List<Object> get props => [errorString];
}

class AuthenticationEmailLoading extends AuthenticationState {
  final bool isLoading;
  const AuthenticationEmailLoading({required this.isLoading});
}
