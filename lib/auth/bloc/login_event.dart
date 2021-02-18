import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({@required this.username, @required this.password,});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class ForgotPasswordButtonPressed extends LoginEvent{

  final String email;

  const ForgotPasswordButtonPressed({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'ForgotPasswordButtonPressed { email: $email }';

}

class LoginPagesNavigation extends LoginEvent{
  @override
  List<Object> get props => [];
}

class ResetPasswordButtonPressed extends LoginEvent{

  final String resetCode;
  final String newPassword;

  const ResetPasswordButtonPressed({@required this.resetCode, @required this.newPassword});

  @override
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'ResetPasswordButtonPressed { resetCode: $resetCode , newPassword: $newPassword }';

}