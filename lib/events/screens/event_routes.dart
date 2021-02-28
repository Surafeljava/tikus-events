import 'package:flutter/material.dart';
import 'package:tikusevents/events/models/event_argument.dart';
import 'package:tikusevents/events/models/my_event_model.dart';
import 'package:tikusevents/events/screens/event_screens.dart';
import 'package:tikusevents/events/screens/my_event_detail.dart';
import 'package:tikusevents/registration/models/models.dart';

class EventRoutes{

  static Route generateRoute(RouteSettings settings){

    if(settings.name == "/"){
      return MaterialPageRoute(builder: (context) => MyEventList());
    }

    if(settings.name == MyEventList.routeName){
      return MaterialPageRoute(builder: (context) => MyEventList());
    }

    if(settings.name == MyEventDetail.routeName){
      MyEventModel eventModel = settings.arguments;
      return MaterialPageRoute(builder: (context) => MyEventDetail(eventModel: eventModel,));
    }

    if(settings.name == EventAddUpdate.routeName){
      EventArgument arg = settings.arguments;
      return MaterialPageRoute(builder: (context) => EventAddUpdate(args: arg,));
    }

  }

}