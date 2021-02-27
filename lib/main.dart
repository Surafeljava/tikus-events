import 'package:flutter/material.dart';
import 'package:tikusevents/authenticate/data_provider/auth_data_provider.dart';
import 'authenticate/repository/auth_repository.dart';
import 'wrapper.dart';
import 'package:http/http.dart' as http;

void main() {

  final AuthRepository authRepository = AuthRepository(
    dataProvider: AuthDataProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(Wrapper(authRepository: authRepository));
}

