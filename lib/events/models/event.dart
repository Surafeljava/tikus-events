import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UserAuth extends Equatable {

  final String userId;
  final String userName;
  final String email;

  UserAuth({this.userId,
        @required this.userName,
        @required this.email,});
  @override
  List<Object> get props => [userId, userName, email];

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      userId: json['user_id'],
      userName: json['user_name'],
      email: json['email'],
    );
  }

  @override
  String toString() => 'userAuth { user_id: $userId, user_name: $userName, email: $email }';
}
