import 'dart:convert';

import 'package:meta/meta.dart';
import 'tikus-events/lib/events/models/event.dart';
import 'package:http/http.dart' as http;

class EventDataProvider {
  final _baseUrl = 'http://192.168.137.1:5000';
  final http.Client httpClient;

  EventDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Event>> getAllEvents() async {
    final response = await httpClient.post('$_baseUrl/event/all');

    if (response.statusCode == 200) {
      final events = jsonDecode(response.body) as List;
      return events.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load Events');
    }
  }

Future<Event> creaateEvent(Event event) async {
  final response = await httpClient.post(
    Uri.http('$_baseUrl', '/event/update'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'event_id': event.event_id,
      'user_id': event.user_id,
      'title': event.title,
      'description': event.description,
      'event_created_on': event.event_created_on,
      'event_begins_on': event.event_begins_on,
      'event_ends_on': event.event_ends_on,
      'event_deadline': event.event_deadline,
      'event_picture': event.event_picture,
      'all_seats': event.all_seats,
      'reserved_seats': event.reserved_seats
    }),
  );

  if (response.statusCode == 200) {
    return Event.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create course.');
  }
}


  Future<void> deleteEvent(String event_id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/event/delete/$event_id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updateEvent(Event event) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/event/update/${event.event_id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'event_id': event.event_id,
        'user_id': event.user_id,
        'title': event.title,
        'description': event.description,
        'event_created_on': event.event_created_on,
        'event_begins_on': event.event_begins_on,
        'event_ends_on': event.event_ends_on,
        'event_deadline': event.event_deadline,
        'event_picture': event.event_picture,
        'all_seats': event.all_seats,
        'reserved_seats': event.reserved_seats
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update course.');
    }
  }
}
