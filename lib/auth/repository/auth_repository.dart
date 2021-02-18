import 'package:flutter/material.dart';
import 'package:tikusevents/auth/models/errorModel.dart';

class AuthRepository {

  Future<List<dynamic>> authenticate({@required String userName, @required String password,}) async {
    await Future.delayed(Duration(seconds: 5));
    //if the result of the database is true
    ErrorModel er = new ErrorModel(errorMessage: 'Wrong Username or Password', hasError: true);
    List<dynamic> result = ['token $userName', er];
    return result;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<bool> forgotPwd({@required String email}) async{
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  Future<bool> resetPwd({@required String resetCode, @required String newPassword}) async{
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

}