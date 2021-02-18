import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/auth/bloc/auth_bloc.dart';
import 'package:tikusevents/auth/bloc/login_bloc.dart';
import 'package:tikusevents/auth/bloc/login_event.dart';
import 'package:tikusevents/auth/bloc/login_state.dart';
import 'package:tikusevents/auth/screens/additional_widgets.dart';

class LoginForm extends StatelessWidget {

  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({Key key, @required this.loginBloc, @required this.authenticationBloc,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController usernameController = new TextEditingController();
    TextEditingController pwdController = new TextEditingController();
    final _loginFormKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state){

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SafeArea(
                    child: Form(
                      key: _loginFormKey,
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
                              child: Text('Login', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, letterSpacing: 2.0, color: Colors.white),),
                            ),

                            BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if(state is LoginFailure){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                                      child: Text(state.error, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.redAccent),),
                                    );
                                  }else{
                                    return Container();
                                  }
                                }
                            ),

                            Hero(
                              tag: 'textField1',
                              child: Padding(
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
                                  controller: usernameController,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(fontSize: 20.0, color: Colors.white, letterSpacing: 2,),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                                    hintText: 'Username',
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
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) {
                                  if(val.isEmpty){
                                    return 'Empty Field';
                                  }else{
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
                            ),




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
                                        child: Text('Log in', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.grey[800]),),
                                      ),
                                    ),
                                    useCache: false,
                                    scaleCoefficient: 0.95,
                                    onTap: (){
                                      if(_loginFormKey.currentState.validate()){
                                        loginWithUsername(usernameController.text.toString(), pwdController.text.toString());
                                      }else{
                                        print(_loginFormKey.currentState.validate());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: SpringButton(
                                SpringButtonType.OnlyScale,
                                Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    )
                                  ),
                                  child: Center(
                                    child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.white),),
                                  ),
                                ),
                                useCache: false,
                                scaleCoefficient: 0.95,
                                onTap: (){
                                  Navigator.pushNamed(context, '/register');
                                },

                              ),
                            ),

                            Hero(
                              tag: 'loginNextPageTextButtons',
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                                    alignment: Alignment.center,
                                    child: Text('Forgot password?', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.lightBlueAccent),),
                                  ),
                                  onTap: (){
                                    BlocProvider.of<LoginBloc>(context).add(LoginPagesNavigation());
                                    Navigator.pushNamed(context, '/forgot');
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

                  (state is LoginLoading) ?
                  AdditionalWidgets(title: 'Checking...').centerLoading() :
                  Container(),

                  (state is LoginFailure) ? Container() : Container(),

                ],
              ),
            );

          },
        ),
      ),
    );
  }

  void loginWithUsername(String uname, String pwd){
    loginBloc.add(LoginButtonPressed(username: uname, password: pwd));
  }

}
