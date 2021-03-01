import 'package:equatable/equatable.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/dashboard_model.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_model.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState{}


class RegisterInitialized extends RegisterState{}

class RegisterCreateSuccess extends RegisterState{

  final String registerMessage;

  RegisterCreateSuccess({this.registerMessage});

  @override
  List<Object> get props => [registerMessage];
}

class RegisterGetSuccessful extends RegisterState{

  final List<EventModel> events;
  final List<RegisterModel> registers;

  RegisterGetSuccessful({this.events, this.registers});

  @override
  List<Object> get props => [events, registers];

}

class AllRegisterGetFailure extends RegisterState{
  final String message;
  AllRegisterGetFailure({this.message});

  @override
  List<Object> get props => [message];
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

class RegisterDeleteSuccess extends RegisterState{}

class RegisterDeleteFailed extends RegisterState{
  final String failedMessage;

  RegisterDeleteFailed({this.failedMessage});

  @override
  List<Object> get props => [failedMessage];
}

class AdminDashBoardGetSuccess extends RegisterState{
  final DashBoardModel dashBoardModel;

  AdminDashBoardGetSuccess({this.dashBoardModel});

  @override
  List<Object> get props => [dashBoardModel];
}

class AdminDashBoardGetFailed extends RegisterState{
  final String failedMessage;

  AdminDashBoardGetFailed({this.failedMessage});

  @override
  List<Object> get props => [failedMessage];
}