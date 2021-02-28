import 'package:flutter/material.dart';

class RegisterModel{

  final int reg_id;
  final int user_id;
  final int event_id;
  final String registered_on;
  final int reserved_seats;

  RegisterModel({this.reg_id, @required this.user_id, @required this.event_id, @required this.registered_on, @required this.reserved_seats});

  factory RegisterModel.fromJson(dynamic json){
    return RegisterModel(
        reg_id: json['reg_id'],
        user_id: json['user_id'],
        event_id: json['event_id'],
        registered_on: json["registered_on"],
        reserved_seats: json['reserved_seats']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'reg_id': reg_id,
        'user_id': user_id,
        'event_id': event_id,
        'registered_on': registered_on,
        'reserved_seats': reserved_seats
      };

}