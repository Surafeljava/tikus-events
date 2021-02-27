import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  bool emailLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthenticateState>(
        builder: (context, state){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Forgot Password Page!"),

                    SizedBox(height: 15.0,),

                    state is PasswordForgotSuccess ? Text("Success", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.green),) : Container(),
                    state is PasswordForgotFailed ? Text("Failed", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.redAccent),) : Container(),



                    state is ForgotPasswordPage ?
                    TextButton(
                      child: Text('Send Reset Code'),
                      onPressed: (){
                        String email = "surafelm27@gmail.com";
                        BlocProvider.of<AuthBloc>(context, listen: false).add(PasswordForgotEmail(email: email));
                      },
                    ):
                    Container(),


                    state is PasswordForgotEmailSent ?
                    TextButton(
                      child: Text('Change Password'),
                      onPressed: (){
                        String email = "surafelm27@gmail.com";
                        String password = "654321";
                        String resetCode = "979140";
                        setState(() {
                          emailLoading = false;
                        });
                        BlocProvider.of<AuthBloc>(context, listen: false).add(PasswordForgotChange(email: email, password: password, resetCode: resetCode));
                      },
                    ):
                    Container(),


                    TextButton(
                      child: Text('Back to Login'),
                      onPressed: (){
                        BlocProvider.of<AuthBloc>(context, listen: false).add(AuthInitialize());
                      },
                    ),

                  ],
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
    );
  }
}
