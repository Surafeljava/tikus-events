import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/authenticate/bloc/auth_bloc.dart';
import 'package:tikusevents/authenticate/bloc/auth_event.dart';
import 'package:tikusevents/authenticate/bloc/auth_state.dart';
import 'package:tikusevents/authenticate/screens/user_create.dart';

class Login extends StatefulWidget {

  static const routeName = '/auth/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthenticateState>(
            listener: (context, state){
              if(state is LoggingInProgress){
                final snackBar = SnackBar(content: Text("Loading..."));
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }else if(state is LoggingInFailed){
                final snackBar = SnackBar(content: Text(state.message));
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }
            },
            builder: (context, state){
             return Stack(
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width,
                   child: Form(
                  
                     key: _formKey,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [


                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 10.0),
                           child: Text('LOGIN', style: TextStyle(fontSize: 30.0, color: Colors.grey[900], fontWeight: FontWeight.w600, letterSpacing: 1.0),),
                         ),

//                       state is LoggingInFailed ? Text('Error: ${state.message}') : Container(),

                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                           child: TextFormField(
                             autofocus: false,
                             validator: (val){
                               if(val.isEmpty){
                                 return 'Empty Field';
                               }else if(!validateEmail(val)){
                                 return 'Use valid email';
                               }else{
                                 return null;
                               }
                             },
                             controller: emailController,
                             keyboardType: TextInputType.emailAddress,
                             style: TextStyle(fontSize: 20.0, color: Colors.black, letterSpacing: 1.0,),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                               hintText: 'Email',
                               hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[900],),
                               filled: true,
                               fillColor: Colors.grey[200],
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10.0),
                                 borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10.0),
                                 borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                               ),
                             ),
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                           child: TextFormField(
                             autofocus: false,
                             validator: (val) => val.isEmpty ? 'Empty Field' : null,
                             controller: passwordController,
                             keyboardType: TextInputType.text,
                             obscureText: true,
                             style: TextStyle(fontSize: 20.0, color: Colors.black, letterSpacing: 1.0,),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                               hintText: 'Password',
                               hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[900],),
                               filled: true,
                               fillColor: Colors.grey[200],
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10.0),
                                 borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10.0),
                                 borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                               ),
                             ),
                           ),
                         ),

                         SpringButton(
                           SpringButtonType.OnlyScale,
                           Container(
                               decoration: BoxDecoration(
                                 color: Colors.grey[800],
                                 borderRadius: BorderRadius.circular(8.0),
                               ),
                               width: MediaQuery.of(context).size.width,
                               height: 50,
                               margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                               child: Center(
                                 child: Text('Login', style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.5),),
                               )
                           ),
                           scaleCoefficient: 0.9,
                           useCache: false,
                           onTap: (){
                             if(_formKey.currentState.validate()){
                               String email = emailController.text;
                               String password = passwordController.text;

                               BlocProvider.of<AuthBloc>(context, listen: false).add(AuthLogin(email: email, password: password));
                             }else{
                               setState(() {
                                 _autoValidate = true;
                               });
                             }
                           },
                         ),

                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("I don't have account", style: TextStyle(fontSize: 16.0, color: Colors.grey[800], fontWeight: FontWeight.w400, letterSpacing: 1.0),),
                               SizedBox(width: 5.0,),
                               TextButton(
                                 child: Text('SignUp', style: TextStyle(fontSize: 16.0, color: Colors.deepOrange, fontWeight: FontWeight.w400, letterSpacing: 1.0),),
                                 onPressed: (){
                                   Navigator.of(context).pushNamed(UserCreate.routeName);
                                   BlocProvider.of<AuthBloc>(context, listen: false).add(AuthInitialize());
                                 },
                               ),
                             ],
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               TextButton(
                                 child: Text('Back', style: TextStyle(fontSize: 16.0, color: Colors.deepOrange, fontWeight: FontWeight.w400, letterSpacing: 1.0),),
                                 onPressed: (){
                                   BlocProvider.of<AuthBloc>(context, listen: false).add(AuthInitialize());
                                 },
                               ),
                             ],
                           ),
                         ),

                       ],
                     ),
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
      ),
    );
  }
}
