import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tikusevents/events/data_provider/event_data_provider.dart';
import 'package:tikusevents/events/event.dart';
import 'package:tikusevents/events/repository/event_repository.dart';
import 'package:tikusevents/registration/models/models.dart';
import 'package:tikusevents/registration/screens/admin_dash_board.dart';
import 'package:tikusevents/registration/screens/register_screens.dart';
import 'package:http/http.dart' as http;

class RegisterRoutes{
  static Route generateRoute(RouteSettings settings){

    if(settings.name == "/"){
      return MaterialPageRoute(builder: (context) => EventsList());
    }

    if(settings.name == EventsList.routeName){
      return MaterialPageRoute(builder: (context) => EventsList());
    }

    if(settings.name == EventsDetail.routeName){
      EventModel eventModel = settings.arguments;
      return MaterialPageRoute(builder: (context) => EventsDetail(eventModel: eventModel,));
    }

    if(settings.name == RegisterList.routeName){
      return MaterialPageRoute(builder: (context) => RegisterList());
    }

    if(settings.name == RegisterDetail.routeName){
      List<dynamic> models = settings.arguments;
      RegisterModel registerModel = models[0];
      EventModel eventModel = models[1];
      return MaterialPageRoute(builder: (context) => RegisterDetail(registerModel: registerModel, eventModel: eventModel,));
    }

    if(settings.name == RegisterAddUpdate.routeName){
      RegisterArgument arg = settings.arguments;
      return MaterialPageRoute(builder: (context) => RegisterAddUpdate(args: arg,));
    }

    if(settings.name == Event.routeName){
      final EventRepository eventRepository = EventRepository(
        eventDataProvider: EventDataProvider(
          httpClient: http.Client(),
        ),
      );

      return MaterialPageRoute(builder: (context) => Event(eventRepository: eventRepository));
    }

    if(settings.name == AdminDashBoard.routeName){
      return MaterialPageRoute(builder: (context) => AdminDashBoard());
    }

  }
}