import 'package:equatable/equatable.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';

class AuthenticateState extends Equatable {
  const AuthenticateState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthenticateState{}

class TheLoading extends AuthenticateState{}

class AuthInitial extends AuthenticateState{}

class Authenticated extends AuthenticateState{

  final AuthModel result;

  Authenticated([this.result]);

  @override
  List<Object> get props => [result];

}

class NotAuthenticated extends AuthenticateState{}

class AuthFailed extends AuthenticateState{
  final String message;

  AuthFailed([this.message]);

  @override
  List<Object> get props => [message];
}

class RegistrationSuccess extends AuthenticateState{
  final String message;
  RegistrationSuccess({this.message});
  @override
  List<Object> get props => [message];
}

class RegistrationInProgress extends AuthenticateState{}

class LoggingInProgress extends AuthenticateState{}

class LoggingInPage extends AuthenticateState{}

class LoggingInFailed extends AuthenticateState{
  final String message;
  LoggingInFailed({this.message});
  @override
  List<Object> get props => [message];
}

class ForgotPasswordPage extends AuthenticateState{}

class PasswordForgotInProgress extends AuthenticateState{}

class PasswordForgotFailed extends AuthenticateState{
  final String message;
  PasswordForgotFailed({this.message});
  @override
  List<Object> get props => [message];
}

class PasswordForgotEmailSent extends AuthenticateState{}

class PasswordForgotSuccess extends AuthenticateState{
  final String message;
  PasswordForgotSuccess({this.message});
  @override
  List<Object> get props => [message];
}
