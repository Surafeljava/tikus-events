import 'package:meta/meta.dart';
import 'package:tikusevents/events/data_provider/event_data_provider.dart';
import 'package:tikusevents/registration/models/event_model.dart';

class EventRepository {
  final EventDataProvider eventDataProvider;

  EventRepository({@required this.eventDataProvider})
      : assert(eventDataProvider != null);

  //gets all Events
  Future<List<EventModel>> getEvents() async {
    return await eventDataProvider.getAllEvents();
  }


}
