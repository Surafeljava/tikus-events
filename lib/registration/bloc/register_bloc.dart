import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/dashboard_model.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_model.dart';
import 'package:tikusevents/registration/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  final RegisterRepository registerRepository;

  RegisterBloc({@required this.registerRepository})
      : assert(registerRepository != null),
        super(RegisterLoading());

  List<EventModel> events = [];

  Future<String> getAllEventsOfRegisters() async{

  }

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
        yield RegisterCreateSuccess(registerMessage: result[1]);
      }else{
        yield RegistrationToEventFailure(failedMessage: result[1]);
      }
    }

    if(event is RegisterGetAll){
      yield RegisterLoading();
      List<dynamic> result = await registerRepository.getRegisters();
      if(result[0]){
        List<RegisterModel> registers = result[1][1];
        List<EventModel> events = result[1][0];
        yield RegisterGetSuccessful(events: events, registers: registers);
      }else{
        yield AllRegisterGetFailure(message: result[1]);
      }
    }

    if(event is RegisterUpdate){
      yield RegisterLoading();
      List<dynamic> result = await registerRepository.updateRegisters(event.registerModel);
      if(result[0]){
        yield RegisterCreateSuccess(registerMessage: result[1]);
      }else{
        yield RegistrationToEventFailure(failedMessage: result[1]);
      }
    }


    if(event is RegisterDelete){
      yield RegisterLoading();
      List<dynamic> result = await registerRepository.deleteRegister(event.registerModel);
      if(result[0]){
        yield RegisterDeleteSuccess();
      }else{
        yield RegisterDeleteFailed(failedMessage: result[1]);
      }
    }


    if(event is AdminDashBoardGet){
      yield RegisterLoading();
      List<dynamic> result = await registerRepository.getAdminData();
      if(result[0]){
        List<int> info = result[1];
        yield AdminDashBoardGetSuccess(
          dashBoardModel: DashBoardModel(events: info[0], registrations: info[1], users: info[2])
        );
      }else{
        yield AdminDashBoardGetFailed(failedMessage: result[1]);
      }
    }



  }

}