import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventDataProvider{
  static final _baseUrl = 'http://192.168.137.1:5000';
  final http.Client httpClient;

  EventDataProvider({@required this.httpClient}) : assert(httpClient != null);



}