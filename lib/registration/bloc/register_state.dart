import 'package:equatable/equatable.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_model.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState{}


class RegisterInitialized extends RegisterState{}

class RegisterGetSuccessful extends RegisterState{

  final List<RegisterModel> registers;

  RegisterGetSuccessful({this.registers});

  @override
  List<Object> get props => [registers];

}

class RegisterCreateSuccess extends RegisterState{

  final RegisterModel registerModel;

  RegisterCreateSuccess({this.registerModel});

  @override
  List<Object> get props => [registerModel];

}


class EventGetSuccessful extends RegisterState{

  final List<EventModel> eventModels;

  EventGetSuccessful({this.eventModels});

  @override
  List<Object> get props => [eventModels];
}


class AllEventGetFailure extends RegisterState{

  final String message;
  AllEventGetFailure({this.message});

  @override
  List<Object> get props => [message];
}


class RegistrationToEventFailure extends RegisterState{

  final String failedMessage;

  RegistrationToEventFailure({this.failedMessage});

  @override
  List<Object> get props => [failedMessage];

}