import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/app_route.dart';
import 'package:tikusevents/authenticate/bloc/bloc.dart';

class ForgotPassword extends StatefulWidget {

  static const routeName = '/auth/password/forgot';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {


  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController resetCodeController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  bool emailLoading = true;

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
        body: BlocConsumer<AuthBloc, AuthenticateState>(
          listener: (context, state){
            if(state is PasswordForgotInProgress){
              final snackBar = SnackBar(content: Text("Loading..."));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }else if(state is PasswordForgotFailed){
              final snackBar = SnackBar(content: Text(state.message));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }else if(state is PasswordForgotEmailSent){
              final snackBar = SnackBar(content: Text("Email sent to: ${emailController.text}"));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }else if(state is PasswordForgotSuccess){
              final snackBar = SnackBar(content: Text("Password Changed!"));
              _scaffoldKey.currentState.showSnackBar(snackBar);
              BlocProvider.of<AuthBloc>(context, listen: false).add(AuthInitialize());
            }
          },
          builder: (context, state){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    // autovalidate: _autoValidate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('Password Recovery', style: TextStyle(fontSize: 30.0, color: Colors.grey[900], fontWeight: FontWeight.w600, letterSpacing: 1.0),),
                        ),

                        state is ForgotPasswordPage ? Padding(
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
                        ) : Container(),

                        state is ForgotPasswordPage ? SpringButton(
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
                                child: Text('Send Reset Code', style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.0),),
                              )
                          ),
                          scaleCoefficient: 0.9,
                          useCache: false,
                          onTap: (){
                            if(_formKey.currentState.validate()){
                              String email = emailController.text;
                              BlocProvider.of<AuthBloc>(context, listen: false).add(PasswordForgotEmail(email: email));
                            }else{
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          },
                        ) : Container(),



                        state is PasswordForgotEmailSent ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            validator: (val){
                              if(val.isEmpty){
                                return 'Empty Field';
                              }else{
                                return null;
                              }
                            },
                            controller: resetCodeController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20.0, color: Colors.black, letterSpacing: 1.0,),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                              hintText: 'Reset Code',
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
                        ) : Container(),

                        state is PasswordForgotEmailSent ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            validator: (val){
                              if(val.isEmpty){
                                return 'Empty Field';
                              }else{
                                return null;
                              }
                            },
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
                        ) : Container(),

                        state is PasswordForgotEmailSent ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            validator: (val){
                              if(val.isEmpty){
                                return 'Empty Field';
                              }else if(passwordController.text != val){
                                return "Password doesn't match!";
                              }else{
                                return null;
                              }
                            },
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(fontSize: 20.0, color: Colors.black, letterSpacing: 1.0,),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                              hintText: 'Confirm Password',
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
                        ) : Container(),


                        state is PasswordForgotEmailSent ? SpringButton(
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
                                child: Text('Send Reset Code', style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.0),),
                              )
                          ),
                          scaleCoefficient: 0.9,
                          useCache: false,
                          onTap: (){
                            if(_formKey.currentState.validate()){
                              String email = emailController.text;
                              String password = passwordController.text;
                              String resetCode = resetCodeController.text;
                              setState(() {
                                emailLoading = false;
                              });
                              BlocProvider.of<AuthBloc>(context, listen: false).add(PasswordForgotChange(email: email, password: password, resetCode: resetCode));
                            }else{
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          },
                        ) : Container(),

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
                  ),

                  state is PasswordForgotInProgress ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width*0.5,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(emailLoading ? "Sending\nReset Code." : "Changing\nPassword.", style: TextStyle(fontSize: 17.0, letterSpacing: 1.0, fontWeight: FontWeight.w400, color: Colors.grey[800]), textAlign: TextAlign.center,),
                            SizedBox(height: 20.0,),
                            SpinKitFadingCircle(
                              color: Colors.redAccent,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ): Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
