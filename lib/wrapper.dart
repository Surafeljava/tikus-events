import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/auth/bloc/auth_bloc.dart';
import 'package:tikusevents/auth/bloc/auth_state.dart';
import 'package:tikusevents/auth/screens/forgot_password.dart';
import 'package:tikusevents/auth/screens/login.dart';
import 'package:tikusevents/home/home.dart';
import 'package:tikusevents/splash/splashPage.dart';

import 'auth/bloc/auth_event.dart';
import 'auth/repository/auth_repository.dart';

class Wrapper extends StatefulWidget {

  final AuthRepository authRepository;

  Wrapper({Key key, @required this.authRepository}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  AuthenticationBloc authenticationBloc;
  AuthRepository get authRepository => widget.authRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(authRepository: authRepository);
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authenticationBloc,
      child: BlocBuilder<AuthenticationBloc, AuthState>(builder: (context, state){
        if(state is AuthenticationUninitialized){
          return SplashPage(authenticationBloc: authenticationBloc,);
        }else if(state is AuthenticationAuthenticated){
          return HomePage();
        }else if(state is AuthenticationUnauthenticated){
          return LoginPage(authRepository: authRepository);
        }else if(state is AuthenticationLoading){
          return Scaffold(
            body: Center(child: Text('Loading'),),
          );
        }else{
          return HomePage();
        }
      },
      ),
    );
  }
}
