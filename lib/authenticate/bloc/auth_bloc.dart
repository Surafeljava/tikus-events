import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/authenticate/repository/auth_repository.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthenticateEvent, AuthenticateState>{

  final AuthRepository authRepository;

  AuthBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(AuthLoading());

  @override
  Stream<AuthenticateState> mapEventToState(AuthenticateEvent event) async*{
    if(event is AuthLoad){
      yield AuthLoading();
      await Future.delayed(Duration(seconds: 2));
      try{
        bool result = await authRepository.loggedInCheck();
        if(result){
          List<dynamic> userInfo = await authRepository.getUserInfo();
          if(userInfo[0]){
            yield Authenticated(userInfo[1]);
          }else{
            yield AuthFailed(userInfo[1]);
          }
        }else{
          yield AuthInitial();
        }
      }catch(e){
        yield AuthFailed();
      }
    }

    if(event is AuthInitialize){
      yield AuthInitial();
    }

    if(event is LoggingIn){
      yield LoggingInPage();
    }

    if(event is AuthLogin){
      yield LoggingInProgress();
      try{
        List<dynamic> result = await authRepository.login(event.email, event.password);
        if(result[0]){
          List<dynamic> userInfo = await authRepository.getUserInfo();
          if(userInfo[0]){
            yield Authenticated(userInfo[1]);
          }else{
            yield LoggingInFailed(message: userInfo[1]);
          }
        }else{
          yield LoggingInFailed(message: result[1]);
        }
      }catch(e){
        yield LoggingInFailed(message: "Error trying to login!");
      }
    }

    if(event is AuthLogout){
      //Do This
      yield TheLoading();
      bool result = await authRepository.logout();
      if(result){
        yield AuthInitial();
      }else{
        yield AuthFailed("Error Logging Out");
      }

    }

    if(event is RegisterUser){
      //Do This
      yield RegistrationInProgress();
      try{
        bool result = await authRepository.userCreate(event.authModel, event.image);
        if(result){
          yield RegistrationSuccess(message: "Success");
        }else{
          yield AuthFailed("Failed to create user!");
        }
      }catch(e) {
        yield AuthFailed("Failed");
      }
    }

    if(event is ForgotPasswordInitial){
      yield ForgotPasswordPage();
    }

    if(event is PasswordForgotEmail){
      //Do This
      yield PasswordForgotInProgress();
      try{
        bool result = await authRepository.forgotPasswordSendEmail(event.email);
        if(result){
          yield PasswordForgotEmailSent();
        }else{
          yield PasswordForgotFailed(message: "Error sending email");
        }
      }catch(e){
        yield PasswordForgotFailed(message: "Failed");
      }
    }

    if(event is PasswordForgotChange){
      //Do This
      yield PasswordForgotInProgress();
      try{
        bool result = await authRepository.forgotPasswordChange(event.email, event.password, event.resetCode);
        if(result){
          await Future.delayed(Duration(seconds: 1));
          yield PasswordForgotSuccess();
        }else{
          yield PasswordForgotFailed(message: "Error sending email");
        }
      }catch(e){
        yield PasswordForgotFailed(message: "Failed");
      }
    }

  }

}