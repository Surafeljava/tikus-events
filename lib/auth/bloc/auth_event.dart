import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {

  @override
  List<Object> get props => [];

  @override
  String toString() => 'App Started!';
}

class LoggedIn extends AuthEvent {
  final String token;

  const LoggedIn(this.token);

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn {token: $token}';
}

class LoggedOut extends AuthEvent {

  @override
  List<Object> get props => [];

  @override
  toString() => 'LoggedOut!';
}
