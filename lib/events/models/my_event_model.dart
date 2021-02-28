import 'package:flutter/material.dart';
import 'package:tikusevents/events/data_provider/event_data_provider.dart';

class MyEventModel{

  final int eventId;
  final int userId;
  final String title;
  final String description;
  final String eventCreatedOn;
  final String eventBeginsOn;
  final String eventEndsOn;
  final String eventDeadline;
  final String eventPicture;
  final int allSeats;
  final int reservedSeats;

  MyEventModel({
    this.eventId,
    @required this.userId,
    @required this.title,
    @required this.description,
    @required this.eventCreatedOn,
    @required this.eventBeginsOn,
    @required this.eventEndsOn,
    @required this.eventDeadline,
    @required this.eventPicture,
    @required this.allSeats,
    @required this.reservedSeats
  });

  factory MyEventModel.fromJson(dynamic json){
    return MyEventModel(
      eventId: json['event_id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      eventCreatedOn: json['event_created_on'],
      eventBeginsOn: json['event_begins_on'],
      eventEndsOn: json['event_ends_on'],
      eventDeadline: json['event_deadline'],
      eventPicture: '${EventDataProvider.baseUrl}/event/pic/get?pic=${json['event_picture']}',
      allSeats: json['all_seats'],
      reservedSeats: json['reserved_seats'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'event_id': eventId,
        'user_id': userId,
        'title': title,
        'description': description,
        'event_created_on': eventCreatedOn,
        'event_begins_on': eventBeginsOn,
        'event_ends_on': eventEndsOn,
        'event_deadline': eventDeadline,
        'event_picture': eventPicture,
        'all_seats': allSeats,
        'reserved_seats': reservedSeats,
      };

}