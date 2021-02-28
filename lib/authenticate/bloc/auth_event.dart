import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();
}

class AuthLoad extends AuthenticateEvent{
  @override
  List<Object> get props => [];
}

class Loading extends AuthenticateEvent{
  @override
  List<Object> get props => [];

}

class AuthInitialize extends AuthenticateEvent{

  @override
  List<Object> get props => [];

}

class AuthLogin extends AuthenticateEvent{

  final String email;
  final String password;
  AuthLogin({this.email, this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'Logging in {email: $email}';

}

class LoggingIn extends AuthenticateEvent{
  @override
  List<Object> get props => [];

}

class AuthLogout extends AuthenticateEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Logged Out!';
}

class RegisterUser extends AuthenticateEvent{

  final File image;
  final AuthModel authModel;

  RegisterUser({this.image, this.authModel});

  @override
  List<Object> get props => [image, authModel];

}

class ForgotPasswordInitial extends AuthenticateEvent{
  @override
  List<Object> get props => [];

}

class PasswordForgotEmail extends AuthenticateEvent{

  final String email;

  PasswordForgotEmail({this.email});

  @override
  List<Object> get props => [email];

}

class PasswordForgotChange extends AuthenticateEvent{
  final String email, password, resetCode;

  PasswordForgotChange({this.email, this.password, this.resetCode});

  @override
  List<Object> get props => [email, password, resetCode];
}

