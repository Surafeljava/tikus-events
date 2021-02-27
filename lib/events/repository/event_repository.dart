import 'package:meta/meta.dart';
import 'package:tikus_event/events/models/event.dart';
import 'package:tikus_event/events/data_provider/forEvent_data.dart';

class EventRepository{
  final EventDataProvider eventDataProvider;

  ForEventRepository({@required this.eventDataProvider})
      : assert(eventDataProvider != null);

  Future<List<Event>> getEvents() async {
    return await eventDataProvider.getAllEvents();
  }

  Future<void> updateEventr(Event event) async {
     await dataProvider.updateEvent(event);
   }
  
 Future<void> deleteEvent(String event_id) async {
     await dataProvider.deleteEvent(event_id);
   }
}
