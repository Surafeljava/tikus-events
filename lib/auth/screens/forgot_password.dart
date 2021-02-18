import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/auth/bloc/login_bloc.dart';
import 'package:tikusevents/auth/bloc/login_event.dart';
import 'package:tikusevents/auth/bloc/login_state.dart';

import 'additional_widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController resetCodeController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController pwdConfirmController = new TextEditingController();

  final _forgotPwdFormKey = GlobalKey<FormState>();

  bool emailSending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SafeArea(
                    child: Form(
                      key: _forgotPwdFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'loginTikusEvents',
                              transitionOnUserGestures: true,
                              child: Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                  child: Text('Tikus Events', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700, letterSpacing: 2.5, color: Colors.white),),
                                ),
                              ),
                            ),
                            Hero(
                              tag: 'loginMotto',
                              transitionOnUserGestures: true,
                              child: Material(
                                color: Colors.transparent,
                                child: Text('Life is an event. Make it \nmemorable.', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: Colors.white70), textAlign: TextAlign.center,),
                              ),
                            ),
                            Spacer(),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text('Forgot Password', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, letterSpacing: 2.0, color: Colors.white),),
                            ),

                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if(state is LoginFailure){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: Text(state.error, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, letterSpacing: 2.0, color: Colors.redAccent),),
                                  );
                                }else{
                                  return Container();
                                }
                              }
                            ),

                            (state is LoginInitial || state is LoginFailure) ? Hero(
                              tag: 'textField1',
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  autofocus: false,
                                  validator: (val) {
                                    bool check = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val);
                                    if(val.isEmpty){
                                      return 'Empty Field';
                                    }else if(!check){
                                      return 'Not Valid Email';
                                    } else{
                                      return null;
                                    }
                                  },
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(fontSize: 20.0, color: Colors.white, letterSpacing: 2,),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.white70,),
                                    filled: true,
                                    fillColor: Colors.white12,
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
                            ) : Container(),

                            (state is ForgotPwdWaitingEmailSend) ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) {
                                  if(val.isEmpty){
                                    return 'Empty Field';
                                  } else{
                                    return null;
                                  }
                                },
                                controller: resetCodeController,
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(fontSize: 20.0, color: Colors.white, letterSpacing: 2,),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                                  hintText: 'Reset Code',
                                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white70,),
                                  filled: true,
                                  fillColor: Colors.white12,
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

                            (state is ForgotPwdWaitingEmailSend) ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) {
                                  if(val.isEmpty){
                                    return 'Empty Field';
                                  }if(val.length < 6){
                                    return 'Minimum 6 characters';
                                  } else{
                                    return null;
                                  }
                                },
                                controller: pwdController,
                                keyboardType: TextInputType.visiblePassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: true,
                                style: TextStyle(fontSize: 20.0, color: Colors.white, letterSpacing: 2,),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white70,),
                                  filled: true,
                                  fillColor: Colors.white12,
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

                            (state is ForgotPwdWaitingEmailSend) ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) {
                                  if(val.isEmpty){
                                    return 'Empty Field';
                                  } else if(val!=pwdController.text){
                                    return "Password does not match!";
                                  }else{
                                    return null;
                                  }
                                },
                                controller: pwdConfirmController,
                                keyboardType: TextInputType.visiblePassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: true,
                                style: TextStyle(fontSize: 20.0, color: Colors.white, letterSpacing: 2,),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white70,),
                                  filled: true,
                                  fillColor: Colors.white12,
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

                            Hero(
                              tag: 'buttonMainLogin',
                              child: Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SpringButton(
                                    SpringButtonType.OnlyScale,
                                    Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(emailSending ? 'Send email' : 'Reset Password', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.grey[800]),),
                                      ),
                                    ),
                                    useCache: false,
                                    scaleCoefficient: 0.95,
                                    onTap: (){
                                      if(emailSending){
                                        if(_forgotPwdFormKey.currentState.validate()){
                                          BlocProvider.of<LoginBloc>(context).add(ForgotPasswordButtonPressed(email: emailController.text));
                                          setState(() {
                                            emailController.text = '';
                                            emailSending = !emailSending;
                                          });
                                        }else{
                                          print(_forgotPwdFormKey.currentState.validate());
                                        }
                                      }else{
                                        if(_forgotPwdFormKey.currentState.validate()){
                                          BlocProvider.of<LoginBloc>(context).add(ResetPasswordButtonPressed(resetCode: resetCodeController.text, newPassword: pwdController.text));
                                        }else{
                                          print(_forgotPwdFormKey.currentState.validate());
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),


                            Hero(
                              tag: 'loginNextPageTextButtons',
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    alignment: Alignment.center,
                                    child: Text('Back to Login', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.lightBlueAccent),),
                                  ),
                                  onTap: (){
                                    BlocProvider.of<LoginBloc>(context).add(LoginPagesNavigation());
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),

                            Spacer(),

                          ],
                        ),
                      ),
                    ),
                  ),

                  BlocProvider.of<LoginBloc>(context).state == LoginLoading() ? AdditionalWidgets(title: !emailSending ? 'Sending Email...' : 'Changing Password...').centerLoading() : Container()

                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
