import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';
import 'package:tikusevents/authenticate/screens/auth_menu.dart';
import 'package:tikusevents/authenticate/screens/auth_screens.dart';

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
            AuthModel user = state.result[1];
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(user.profileUrl),
                )
              ),
              child: Center(
                child: TextButton(
                  child: Text("${user.userName} Logout"),
                  onPressed: (){
                    BlocProvider.of<AuthBloc>(context, listen: false).add(AuthLogout());
                  },
                ),
              ),
            );
          }

          else{
            return AuthMenu();
          }

        },
      ),
    );
  }
}
