import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterDataProvider{
  static final _baseUrl = 'http://192.168.137.1:5000';
  final http.Client httpClient;
  

  RegisterDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<RegisterModel> creaateRegistration(RegisterModel register) async {
    final response = await httpClient.post(
      Uri.http('$_baseUrl', '/register/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'reg_id': register.reg_id,
        'user_id': register.user_id,
        'event_id': register.event_id,
        'registered_on': register.registered_on,
        'reserved_seats': register.reserved_seats,
      }),
    );

    if (response.statusCode == 200) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create course.');
    }
  }

  Future<List<RegisterModel>> getAllRegisters() async {
    final response = await httpClient.post('$_baseUrl/register/all');

    if (response.statusCode == 200) {
      final registers = jsonDecode(response.body) as List;
      return registers.map((register) => Registor.fromJson(register)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<void> deleteRegistration(int reg_id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/register/delete/$reg_id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updateRegistration(RegisterModel registor) async {
    final http.Response register = await httpClient.put(
      '$_baseUrl/register/update/${register.reg_id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'reg_id': register.reg_id,
        'user_id': register.user_id,
        'event_id': register.event_id,
        'registered_on': register.registered_on,
        'reserved_seats': register.reserved_seats,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update course.');
    }
  }
}
