import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  final RegisterRepository registerRepository;

  RegisterBloc({@required this.registerRepository})
      : assert(registerRepository != null),
        super(RegisterLoading());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{

    if(event is RegisterInitialize){
      yield RegisterInitialState();
    }

  }

}