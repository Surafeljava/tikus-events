import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Event extends Equatable {
  Event(
      {@required this.event_id,
        @required this.user_id,
        @required this.title,
        @required this.description,
        @required this.event_created_on,
        @required this.event_begins_on,
        @required this.event_ends_on,
        @required this.event_deadline,
        @required this.event_picture,
        @required this.to_be_accepted_users_num,
        @required this.registered_users_num,
        @required this.all_seats,
        @required this.reserved_seats});

  final int event_id;
  final int user_id;
  final String title;
  final String description;
  final String event_created_on;
  final String event_begins_on;
  final String event_ends_on;
  final String event_deadline;
  final String event_picture;
  final int to_be_accepted_users_num;
  final int registered_users_num;
  final int all_seats;
  final int reserved_seats;



  @override
  List<Object> get props => [event_id, user_id, title, description,event_created_on,event_begins_on,event_ends_on,event_deadline,event_picture,to_be_accepted_users_num,registered_users_num,all_seats,reserved_seats];

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      event_id: json['event_id'],
      user_id: json['user_id'],
      title: json['title'],
      description: json['description'],
      event_created_on: json['event_created_on'],
      event_begins_on: json['event_begins_on'],
      event_ends_on: json['event_ends_on'],
      event_deadline: json['event_deadline'],
      event_picture: json['event_picture'],
      to_be_accepted_users_num: json['to_be_accepted_users_num'],
      registered_users_num: json['registered_users_num'],
      all_seats: json['all_seats'],
    );
  }

  @override
  String toString() => 'Event { event_id: $event_id, title: $title, description: $description,'
      ' user_id: $user_id, event_created_on:$event_created_on, event_begins_on:$event_begins_on'
      'event_ends_on:$event_ends_on, event_deadline:$event_deadline, event_picture: $event_picture'
      'to_be_accepted_users_num: $to_be_accepted_users_num,registered_users_num:$registered_users_num,all_seats:$all_seats}';
}
