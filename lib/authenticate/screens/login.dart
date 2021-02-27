import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tikusevents/authenticate/bloc/auth_bloc.dart';
import 'package:tikusevents/authenticate/bloc/auth_event.dart';
import 'package:tikusevents/authenticate/bloc/auth_state.dart';

class Login extends StatefulWidget {

  static const routeName = '/auth/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthenticateState>(
          builder: (context, state){
           return Stack(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage('http://192.168.137.1:5000/user/pic/get?pic=2ef57a00-76f0-11eb-aba1-f48e38f1657b.jpg'),
//                 fit: BoxFit.cover
//               ),
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [

                     state is LoggingInFailed ? Text('Error: ${state.message}') : Container(),

                     SizedBox(height: 20.0,),

                     ElevatedButton(
                       child: Text('Login'),
                       onPressed: (){
                         //login here

                         String myEmail = "surafelm27@gmail.com";
                         String password = "654321";

                         print("*** login begin");
                         BlocProvider.of<AuthBloc>(context, listen: false).add(AuthLogin(email: myEmail, password: password));
                         print("*** login done");
                       },
                     ),
                   ],
                 )
               ),

               state is LoggingInProgress ?
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height,
                 decoration: BoxDecoration(
                   color: Colors.black54,
                 ),
                 child: Center(
                   child: SpinKitFadingCircle(
                     color: Colors.white,
                     size: 30.0,
                   ),
                 ),
               ): Container()

             ],
           );
          },
        ),
      ),
    );
  }
}
