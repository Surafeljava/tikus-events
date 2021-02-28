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

