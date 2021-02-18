import 'package:flutter/material.dart';

class ErrorModel{
  final bool hasError;
  final String errorMessage;

  ErrorModel({@required this.hasError,
    @required this.errorMessage,});

  bool get getHasError => hasError;
  String get getErrorMessage => errorMessage;

}