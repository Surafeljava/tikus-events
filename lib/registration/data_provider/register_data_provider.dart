import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_model.dart';

class RegisterDataProvider{
  static final _baseUrl = 'http://192.168.137.1:5000';
  final http.Client httpClient;

  RegisterDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> getTokenFromSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    return token;
  }

  Future<List<dynamic>> createRegister(RegisterModel registerModel) async {
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.post(
      '$_baseUrl/register/update',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': registerModel.user_id,
        'event_id': registerModel.event_id,
        'registered_on': registerModel.registered_on,
        'reserved_seats': registerModel.reserved_seats
      },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      if(myMap["status"]=="failed"){
        return [false, myMap["message"]];
      }else{
        return [true, myMap["message"]];
      }
    } else {
      return [false, 'Error registering to event'];
    }
  }

  Future<List<dynamic>> updateRegister(RegisterModel registerModel) async{
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.put(
      '$_baseUrl/register/update',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
      body: jsonEncode(<String, dynamic>{
        'reg_id': registerModel.reg_id,
        'user_id': registerModel.user_id,
        'event_id': registerModel.event_id,
        'registered_on': registerModel.registered_on,
        'reserved_seats': registerModel.reserved_seats
      },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      if(myMap["status"]=="failed"){
        return [false, myMap["message"]];
      }else{
        return [true, myMap["message"]];
      }
    } else {
      return [false, 'Error Updating register'];
    }
  }

  Future<List<dynamic>> deleteRegister(RegisterModel registerModel) async{
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.delete(
      '$_baseUrl/register/delete?reg_id=${registerModel.reg_id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
    );

    if (response.statusCode == 200) {
      return [true, registerModel];
    } else {
      return [true, 'Error Deleting registration'];
    }
  }

  Future<List<dynamic>> getRegisters() async {
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.get(
      '$_baseUrl/register/all',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
    );

    if (response.statusCode == 200) {
      List<RegisterModel> registerModels = [];
      Map<String, dynamic> myMap = json.decode(response.body);
      if(myMap["message"]=="success"){
        List<dynamic> registers = myMap["registers"];
        registers.forEach((register) {
          registerModels.add(RegisterModel.fromJson(register));
        });
        return [true, registerModels];
      }else{
        return [false, 'Error Loading registers'];
      }
    } else {
      return [false, 'Error Loading registers'];
    }
  }

  Future<List<dynamic>> getSingleRegister() async{
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.post(
      '$_baseUrl/register/one',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      var register = myMap["register"];
      return [true, RegisterModel.fromJson(register)];
    } else {
      return [false, 'Error Getting single register'];
    }

  }

  Future<List<dynamic>> getSingleEvent(int eventId) async{
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.post(
      '$_baseUrl/event/one',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
      body: jsonEncode(<String, dynamic>{
        'event_id': eventId,
      },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      if(myMap["status"]=="failed"){
        return [false, myMap["event"]];
      }else{
        return [true, EventModel.fromJson(myMap["event"])];
      }
    } else {
      return [false, 'Failed to get single event'];
    }

  }


  Future<List<dynamic>> getEvents() async {
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.get(
      '$_baseUrl/event/all',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
    );

    if(response.statusCode == 200){
      List<EventModel> eventModels = [];
      Map<String, dynamic> myMap = json.decode(response.body);
      List<dynamic> events = myMap["events"];
      events.forEach((event) {
        eventModels.add(
            EventModel.fromJson(event)
        );
      });
      return [true, eventModels];
    }else{
      return [false, 'Error getting events'];
    }
  }


  Future<List<dynamic>> getAdminDashboardData() async {
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.get(
      '$_baseUrl/admin/get',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
    );

    if(response.statusCode == 200){
      List<int> adminData = [];
      Map<String, dynamic> myMap = json.decode(response.body);
      List<dynamic> events = myMap["data"];
      events.forEach((event) {
        adminData.add(event);
      });
      return [true, adminData];
    }else{
      return [false, 'Error getting events'];
    }
  }


}