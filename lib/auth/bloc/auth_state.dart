
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthState {}

class AuthenticationAuthenticated extends AuthState {}

class AuthenticationUnauthenticated extends AuthState {}

class AuthenticationLoading extends AuthState {}