import 'package:meta/meta.dart';
import 'package:tikus-events/lib/events/models/event.dart';
import 'package:tikusevents/events/data_provider/event_data_provider.dart';

class EventRepository {
  final EventDataProvider eventDataProvider;

  ForEventRepository({@required this.eventDataProvider})
      : assert(eventDataProvider != null);

  //gets all Events
  Future<List<Event>> getEvents() async {
    return await eventDataProvider.getAllEvents();
  }

  //updates Events
  Future<void> updateEvent(Event event) async {
    await eventDataProvider.updateEvent(event);
  }
  
  //creates Events
  Future<Event> creaateEvent(Event event) async {
    return await eventDataProvider.creaateEvent(event);
  }
  
  //Deletes Events
  Future<void> deleteEvent(String event_id) async {
    await eventDataProvider.deleteEvent(event_id);
  }
}
