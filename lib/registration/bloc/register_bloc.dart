import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_model.dart';
import 'package:tikusevents/registration/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  final RegisterRepository registerRepository;

  RegisterBloc({@required this.registerRepository})
      : assert(registerRepository != null),
        super(RegisterLoading());

  List<EventModel> events = [];

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{

    if(event is RegisterInitialize){
      yield RegisterLoading();
      List<dynamic> result = await registerRepository.getEvents();
      if(result[0]){
        List<EventModel> events = result[1];
        yield EventGetSuccessful(eventModels: events);
      }else{
        yield AllEventGetFailure(message: result[1]);
      }
    }

    if(event is RegisterCreate){
      yield RegisterLoading();
      List<dynamic> result = await registerRepository.createRegister(event.registerModel);
      if(result[0]){
        RegisterModel registerModel = result[1];
        yield RegisterCreateSuccess(registerModel: registerModel);
      }else{
        yield RegistrationToEventFailure(failedMessage: result[1]);
      }
    }

    if(event is RegisterUpdate){
      yield RegisterLoading();
      List<dynamic> result = await registerRepository.createRegister(event.registerModel);
      if(result[0]){
        RegisterModel registerModel = result[1];
        yield RegisterCreateSuccess(registerModel: registerModel);
      }else{
        yield RegistrationToEventFailure(failedMessage: result[1]);
      }
    }



  }

}