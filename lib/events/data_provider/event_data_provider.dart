import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:tikusevents/registration/models/event_model.dart';

class EventDataProvider {
  final _baseUrl = 'http://192.168.137.1:5000';
  final http.Client httpClient;

  EventDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<List<EventModel>> getAllEvents() async {
    final response = await httpClient.post('$_baseUrl/event/all');

    if (response.statusCode == 200) {
      final events = jsonDecode(response.body) as List;
      return events.map((event) => EventModel.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load Events');
    }
  }


}
