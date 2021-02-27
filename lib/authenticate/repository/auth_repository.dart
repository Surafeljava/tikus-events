import 'dart:io';

import 'package:tikusevents/authenticate/data_provider/auth_data_provider.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';

class AuthRepository{

  final AuthDataProvider dataProvider;
  AuthRepository({this.dataProvider});

  Future<bool> userCreate(AuthModel authModel, File profilePic) async {
    return await dataProvider.createUserAccount(authModel, profilePic);
  }

  Future<List<dynamic>> login(String email, String password) async{
    return await dataProvider.userLogin(email, password);
  }

  Future<bool> logout() async{
    return await dataProvider.userLogout();
  }

  Future<bool> loggedInCheck() async{
    return await dataProvider.userLoggedInCheck();
  }

  Future<List<dynamic>> getUserInfo() async{
    return await dataProvider.getUserInfo();
  }

  Future<bool> forgotPasswordSendEmail(String email) async{
    return await dataProvider.forgotPasswordSendEmail(email);
  }

  Future<bool> forgotPasswordChange(String email, String password, String resetCode) async{
    // do something here
    return await dataProvider.forgotPasswordChange(email, password, resetCode);
  }


}