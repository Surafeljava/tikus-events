import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/authenticate/bloc/auth_bloc.dart';
import 'package:tikusevents/authenticate/bloc/auth_event.dart';
import 'package:tikusevents/authenticate/screens/auth_screens.dart';

class AuthMenu extends StatelessWidget {

  static const routeName = '/auth/menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/birabiro.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2,),

              Container(
                width: 80.0,
                child: Image.asset("assets/logo/tikus_logo.png"),
              ),

              Text('Tikus Events', style: TextStyle(fontSize: 32.0, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1.3),),
              Text("Let's celebrate together!", style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.6),),

              Spacer(flex: 1,),
              SpringButton(
                SpringButtonType.OnlyScale,
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Center(
                      child: Text('Login', style: TextStyle(fontSize: 22.0, color: Colors.grey[900], fontWeight: FontWeight.w500, letterSpacing: 1.0),),
                    )
                ),
                scaleCoefficient: 0.9,
                useCache: false,
                onTap: (){
                  BlocProvider.of<AuthBloc>(context, listen: false).add(LoggingIn());
//                  Navigator.of(context).pushNamed(Login.routeName);
                },
              ),

              SpringButton(
                SpringButtonType.OnlyScale,
                Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Center(
                      child: Text('Signup', style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.0),),
                    )
                ),
                scaleCoefficient: 0.9,
                useCache: false,
                onTap: (){
                  Navigator.of(context).pushNamed(UserCreate.routeName);
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Forgot password?", style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 0.6),),
                  TextButton(
                    child: Text("Click Here", style: TextStyle(fontSize: 16.0, color: Colors.yellow, fontWeight: FontWeight.w400, letterSpacing: 0.6),),
                    onPressed: (){
                      BlocProvider.of<AuthBloc>(context, listen: false).add(ForgotPasswordInitial());
                    },
                  ),
                ],
              ),

              Spacer(flex: 1,),
              Text("Hello!", style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 0.6),),
              SizedBox(height: 10.0,)
            ],
          ),
        ),
      ),
    );
  }
}
