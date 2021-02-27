import 'package:flutter/material.dart';
import 'package:tikusevents/authenticate/authenticate.dart';
import 'package:tikusevents/authenticate/screens/auth_screens.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => Authenticate());
    }

    if (settings.name == Login.routeName) {
      return MaterialPageRoute(builder: (context) => Login());
    }

    if (settings.name == AuthMenu.routeName) {
      return MaterialPageRoute(builder: (context) => AuthMenu());
    }

    if (settings.name == UserCreate.routeName) {
      return MaterialPageRoute(builder: (context) => UserCreate());
    }

    if (settings.name == UserUpdate.routeName) {
      return MaterialPageRoute(builder: (context) => UserUpdate());
    }

  }
}


class UserRegisterArgument{
  final Object model;
  final bool edit;
  UserRegisterArgument({this.model, this.edit});
}

class ForgotPasswordArgument{
  final bool emailSent;
  ForgotPasswordArgument({this.emailSent});
}