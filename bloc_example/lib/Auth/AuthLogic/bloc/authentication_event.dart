part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthCreateUser extends AuthenticationEvent {
  final String mail;
  final String password;
  const AuthCreateUser(this.mail, this.password);

  @override
  List<Object> get props => [mail, password];
}

class AuthSignOutUser extends AuthenticationEvent {}

class AuthSignInUser extends AuthenticationEvent {
  final String mail;
  final String password;
  const AuthSignInUser(this.mail, this.password);

  @override
  List<Object> get props => [mail, password];
}

class AuthEmailReset extends AuthenticationEvent {
  final String mail;
  const AuthEmailReset(this.mail);
  @override
  List<Object> get props => [mail];
}


