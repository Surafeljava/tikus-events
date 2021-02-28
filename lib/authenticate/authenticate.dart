import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';
import 'package:tikusevents/authenticate/screens/auth_menu.dart';
import 'package:tikusevents/authenticate/screens/auth_screens.dart';
import 'package:tikusevents/registration/data_provider/register_data_provider.dart';
import 'package:tikusevents/registration/register.dart';
import 'package:tikusevents/registration/repository/register_repository.dart';
import 'package:http/http.dart' as http;

import 'bloc/bloc.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthenticateState>(
        builder: (context, state){
          if(state is AuthLoading){
            return SplashPage();
          }

          if(state is AuthLogin || state is LoggingInProgress || state is LoggingInFailed || state is LoggingInPage){
            return Login();
          }

          if(state is ForgotPasswordPage || state is PasswordForgotSuccess || state is PasswordForgotFailed || state is PasswordForgotEmailSent || state is PasswordForgotInProgress){
            return ForgotPassword();
          }

          if(state is Authenticated){
            final RegisterRepository registerRepository = RegisterRepository(
              dataProvider: RegisterDataProvider(
                httpClient: http.Client(),
              ),
            );
            return Register(registerRepository: registerRepository,);
          }

          else{
            return AuthMenu();
          }

        },
      ),
    );
  }
}
