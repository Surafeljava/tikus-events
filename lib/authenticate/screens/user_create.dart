import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spring_button/spring_button.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  File _image;
  final picker = ImagePicker();
  bool imageGetClicked = false;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordConfirmController = new TextEditingController();

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
      setState(() {
        imageGetClicked = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: BlocConsumer<AuthBloc, AuthenticateState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              final snackBar = SnackBar(content: Text("Loading..."));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else if (state is AuthFailed) {
              final snackBar = SnackBar(content: Text(state.message));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else if (state is RegistrationSuccess) {
              final snackBarRegistered = SnackBar(
                content: Text('Registered'),
                duration: Duration(minutes: 20),
                action: SnackBarAction(
                  label: 'Login Now',
                  textColor: Colors.amber,
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context, listen: false)
                        .add(AuthInitialize());
                    Navigator.of(context).pop();
                  },
                ),
              );
              _scaffoldKey.currentState.showSnackBar(snackBarRegistered);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Form(
                  key: _formKey,
                  // autovalidate: _autoValidate,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                    child: SafeArea(
                      child: Container(
                        color: Colors.white,
                        child: ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(10.0)),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height:
                                      MediaQuery.of(context).size.width * 0.75,
                                  decoration: _image != null
                                      ? BoxDecoration(
                                          color: Colors.grey[200],
                                          image: DecorationImage(
                                              image: FileImage(_image),
                                              fit: BoxFit.cover),
                                        )
                                      : BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 65.0,
                                      height: 65.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0)),
                                      ),
                                      child: IconButton(
                                        iconSize: 45,
                                        icon: Icon(Icons.camera_alt,
                                            color: Colors.black87),
                                        onPressed: () {
                                          setState(() {
                                            imageGetClicked = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) =>
                                    val.isEmpty ? 'Empty Field' : null,
                                controller: userNameController,
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0,
                                ),
                                onChanged: (val) {},
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10),
                                  hintText: 'UserName',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[900],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Empty Field';
                                  } else if (!validateEmail(val)) {
                                    return 'Use valid email';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0,
                                ),
                                onChanged: (val) {},
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[900],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) =>
                                    val.isEmpty ? 'Empty Field' : null,
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0,
                                ),
                                onChanged: (val) {},
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[900],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Empty Field';
                                  } else if (val != passwordController.text) {
                                    return "Password Doesn't Match";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: passwordConfirmController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0,
                                ),
                                onChanged: (val) {},
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10),
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[900],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Center(
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.5),
                                    ),
                                  )),
                              scaleCoefficient: 0.9,
                              useCache: false,
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  String email = emailController.text;
                                  String password = passwordController.text;
                                  String userName = userNameController.text;

                                  DateTime dt = DateTime.now();
                                  AuthModel user = AuthModel(
                                      userId: 0,
                                      userName: userName,
                                      email: email,
                                      password: password,
                                      createdOn:
                                          "${dt.day}/${dt.month}/${dt.year}",
                                      profileUrl: "",
                                      admin: true);
                                  BlocProvider.of<AuthBloc>(context,
                                          listen: false)
                                      .add(RegisterUser(
                                          authModel: user, image: _image));
                                } else {
                                  setState(() {
                                    _autoValidate = true;
                                  });
                                }
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    child: Text(
                                      'Back',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.0),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context,
                                              listen: false)
                                          .add(AuthInitialize());
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                imageGetClicked
                    ? Container(
                        color: Colors.black54,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                      color: Colors.grey[900]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          iconSize: 45,
                                          icon: Icon(Icons.camera,
                                              color: Colors.orange),
                                          onPressed: () async {
                                            await getImage(ImageSource.camera);
                                          },
                                        ),
                                        Text(
                                          'Camera',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1.0,
                                              color: Colors.grey[800]),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          iconSize: 45,
                                          icon: Icon(Icons.photo,
                                              color: Colors.orange),
                                          onPressed: () async {
                                            await getImage(ImageSource.gallery);
                                          },
                                        ),
                                        Text(
                                          'Gallery',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1.0,
                                              color: Colors.grey[800]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                TextButton.icon(
                                  icon: Icon(Icons.close),
                                  label: Text('Cancel'),
                                  onPressed: () {
                                    setState(() {
                                      imageGetClicked = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                state is RegistrationInProgress
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(color: Colors.black54),
                        child: Center(
                          child: SpinKitFadingCircle(
                            size: 35.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ));
  }
}
