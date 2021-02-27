import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterInitialize extends RegisterEvent{

  @override
  List<Object> get props => [];

}

class RegisterLoad extends RegisterEvent{
  @override
  List<Object> get props => [];
}