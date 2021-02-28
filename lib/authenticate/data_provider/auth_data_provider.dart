import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';

class AuthDataProvider{

  static final _baseUrl = 'http://192.168.137.1:5000';
  final http.Client httpClient;

  AuthDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> getTokenFromSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    return token;
  }

  Future<bool> addTokenToSharedPreference(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool stat = await prefs.setString('token', token);
    return stat;
  }

  Future<bool> removeTokenFromSharedPreference(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool stat = await prefs.remove('token');
    return stat;
  }

  Future<bool> userLoggedInCheck() async{
    print("**** Checking login token");
    String tkn = await getTokenFromSharedPreference();
    print("**** Saved Token: $tkn");
    if(tkn==""){
      return false;
    }else{
      return true;
    }
  }


  Future<String> uploadUserProfilePic(File profile) async{

    print("**** Uploading picture");
    print("**** File Path: ${profile.path}");
    String name = '';

    var req = http.MultipartRequest('POST', Uri.parse('$_baseUrl/user/pic'));
    req.files.add(
        http.MultipartFile(
        'pic',
        File(profile.path).readAsBytes().asStream(),
            File(profile.path).lengthSync(),
        filename: profile.path.split("/").last
    ));

    try{
      var res = await req.send();
      name = await res.stream.transform(utf8.decoder).elementAt(0);
    }catch(e){
      print("//*** Error: $e");
    }

    return name;

  }


  Future<bool> createUserAccount(AuthModel authModel, File imageFile) async {

    print("**** Creating user profile");

    // upload the picture and then the file
    String rslt = await uploadUserProfilePic(imageFile);
    var data = jsonDecode(rslt);
    String message = data["message"];
    if(message!="success"){
      return null;
    }

    print("**** Done uploading pictures");

    try{
      final response = await httpClient.post(
        '$_baseUrl/auth/user/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, dynamic>{
          'user_name': authModel.userName,
          'email': authModel.email,
          'password': authModel.password,
          'created_on': authModel.createdOn,
          'profile_url': data["pic"],
          'admin': authModel.admin
        },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create user.');
      }
    }catch(e){
      print("User Create ERROR: $e");
      return false;
    }
  }


  Future<bool> userLogout() async{
    String tn = await getTokenFromSharedPreference();
    bool rslt = await removeTokenFromSharedPreference(tn);
    if(rslt){
      return true;
    }else{
      return false;
    }
  }


  Future<List<dynamic>> getUserInfo() async{
    String tn = await getTokenFromSharedPreference();
    try{
      final response = await httpClient.post(
        '$_baseUrl/auth/user/get',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': tn,
        },
      );

      print("UserInfo: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = json.decode(response.body);
        var user = myMap["user"];
        AuthModel userModel = AuthModel(userName: user['user_name'], email: user['email'], profileUrl: '$_baseUrl/user/pic/get?pic=${user['profile_url']}', admin: user['admin'], createdOn: user['created_on']);
        return [true, userModel];
      } else {
        return [false, "Failed to get User Info."];
      }
    }catch(e){
      return [false, "Failed to get User Info."];
    }
  }


  Future<List<dynamic>> userLogin(String email, String password) async {

    try{
      final response = await httpClient.post(
        '$_baseUrl/auth/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
        },
        ),
      );

      print("*** response: ${response.body}");

      if (response.statusCode == 200) {
        await addTokenToSharedPreference(jsonDecode(response.body)["token"]);
        return [true, jsonDecode(response.body)["token"].toString()];
      } else {
//      throw Exception('Failed to create course.');
        return [false, "Failed to Login"];
      }
    }catch(e){
      print("****///****: $e");
      return [false, "Failed to login!"];
    }
  }


  Future<bool> forgotPasswordSendEmail(String email) async{
    try{
      final response = await httpClient.post(
        '$_baseUrl/password/forgot',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, dynamic>{
          'email': email,
        },
        ),
      );

      print("*** response: ${response.body}");

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body)["message"];
        if(message=="email sent"){
          return true;
        }else{
          return false;
        }
      } else {
        return false;
      }
    }catch(e){
      print("****///****: $e");
      return false;
    }
  }

  Future<bool> forgotPasswordChange(String email, String password, String resetCode) async{
    try{
      final response = await httpClient.post(
        '$_baseUrl/password/change',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
          'code': resetCode
        },
        ),
      );

      print("*** response: ${response.body}");

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body)["message"];
        if(message=="Success"){
          return true;
        }else{
          return false;
        }
      } else {
        return false;
      }
    }catch(e){
      print("****///****: $e");
      return false;
    }
  }



}