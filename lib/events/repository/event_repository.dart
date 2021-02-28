import 'dart:io';

import 'package:meta/meta.dart';
import 'package:tikusevents/events/data_provider/event_data_provider.dart';
import 'package:tikusevents/events/models/my_event_model.dart';

class EventRepository {
  final EventDataProvider eventDataProvider;

  EventRepository({@required this.eventDataProvider})
      : assert(eventDataProvider != null);

  //gets all Events
  Future<List<dynamic>> getAllEvents() async {
    return await eventDataProvider.getAllEvents();
  }

  Future<List<dynamic>> createEvent(MyEventModel eventModel, File _image) async {
    return await eventDataProvider.createEvent(eventModel, _image);
  }

  Future<List<dynamic>> updateEvent(MyEventModel eventModel) async {
    return await eventDataProvider.updateEvent(eventModel);
  }

  Future<List<dynamic>> deleteEvent(MyEventModel eventModel) async {
    return await eventDataProvider.deleteEvent(eventModel);
  }


}
