import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tikusevents/app_route.dart';
import 'package:tikusevents/authenticate/bloc/auth_bloc.dart';
import 'package:tikusevents/authenticate/bloc/auth_event.dart';
import 'package:tikusevents/authenticate/bloc/auth_state.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';
import 'package:tikusevents/authenticate/screens/auth_menu.dart';

class UserCreate extends StatefulWidget {

  static const routeName = '/auth/user/create';
  final UserRegisterArgument args;

  UserCreate({this.args});
  @override
  _UserCreateState createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {

  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthenticateState>(
        builder: (context, state){
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    _image != null ?  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_image),
                              fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ) : Container(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.camera),
                          onPressed: () async{
                            await getImage(ImageSource.camera);
                          },
                        ),
                        SizedBox(width: 20.0,),
                        IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: () async{
                            await getImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 15.0,),

                    state is RegistrationSuccess ? ElevatedButton.icon(
                      label: Text("Login Now"),
                      icon: Icon(Icons.arrow_back_ios, size: 16.0,),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: (){
                        BlocProvider.of<AuthBloc>(context, listen: false).add(AuthInitialize());
                        Navigator.of(context).pop();
                      },
                    ): Container(),

                    SizedBox(height: 15.0,),

                    ElevatedButton.icon(
                      label: Text("Register"),
                      icon: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: (){
                        DateTime dt = DateTime.now();
                        AuthModel user = AuthModel(userId: 0, userName: "Test User", email: "surafelm27@gmail.com", password: "123456", createdOn: "${dt.day}/${dt.month}/${dt.year}", profileUrl: "", admin: false);
                        BlocProvider.of<AuthBloc>(context, listen: false).add(Register(authModel: user, image: _image));


                      },
                    ),
                  ],
                ),
              ),


              state is RegistrationInProgress ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.black54
                ),
                child: Center(
                  child: SpinKitFadingCircle(
                    size: 35.0,
                    color: Colors.white,
                  ),
                ),
              ): Container(),

            ],
          );
        },
      )
    );
  }
}
