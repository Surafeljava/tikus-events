
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tikusevents/auth/models/errorModel.dart';
import 'package:tikusevents/auth/repository/auth_repository.dart';

import 'auth_bloc.dart';
import 'auth_event.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authRepository,
    @required this.authenticationBloc,
  })  : assert(authRepository != null),
        assert(authenticationBloc != null), super(LoginInitial());

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event,) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final List<dynamic> result = await authRepository.authenticate(
          userName: event.username,
          password: event.password,
        );

        ErrorModel er = result[1];

        if(!er.hasError){
          authenticationBloc.add(LoggedIn(result[0]));
          yield LoginInitial();
        }else{
          yield LoginFailure(error: er.errorMessage);
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if(event is ForgotPasswordButtonPressed){

      yield LoginLoading();

      try{
        final bool emailSent = await authRepository.forgotPwd(email: event.email);
        yield ForgotPwdWaitingEmailSend();
      }catch(error){
        yield LoginFailure(error: error.toString());
      }

    }

    if(event is LoginPagesNavigation){
      yield LoginInitial();
    }

    if(event is ResetPasswordButtonPressed){

      yield LoginLoading();

      try{
        final bool resetDone = await authRepository.resetPwd(resetCode: event.resetCode, newPassword: event.newPassword);
        if(!resetDone){
          yield LoginFailure(error: 'Wrong Username or Password!');
        }else{
          yield LoginInitial();
        }
      }catch(error){
        yield LoginFailure(error: error.toString());
      }

    }
  }
}