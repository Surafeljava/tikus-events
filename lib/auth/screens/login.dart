import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/auth/bloc/auth_bloc.dart';
import 'package:tikusevents/auth/bloc/login_bloc.dart';
import 'package:tikusevents/auth/bloc/login_event.dart';
import 'package:tikusevents/auth/bloc/login_state.dart';
import 'package:tikusevents/auth/repository/auth_repository.dart';
import 'package:tikusevents/auth/screens/forgot_password.dart';
import 'package:tikusevents/auth/screens/login_form.dart';
import 'package:tikusevents/auth/screens/registration.dart';

class LoginPage extends StatefulWidget {

  final AuthRepository authRepository;

  LoginPage({Key key, @required this.authRepository}): assert(authRepository != null), super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  AuthRepository get _authRepository => widget.authRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      authRepository: _authRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/birabiro.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xAA000000),
              ),
            ),
            BlocProvider(
              create: (context) => _loginBloc,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                onGenerateRoute: (settings){
                  if(settings.name == '/forgot'){
                    return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
                  }else if(settings.name == '/'){
                    return MaterialPageRoute(builder: (context) => LoginForm(loginBloc: _loginBloc, authenticationBloc: _authenticationBloc,));
                  }else if(settings.name == '/register'){
                    return  MaterialPageRoute(builder: (context) => RegistrationPage());
                  }else{
                    return MaterialPageRoute(builder: (context) => RegistrationPage());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
