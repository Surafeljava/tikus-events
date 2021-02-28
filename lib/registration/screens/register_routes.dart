import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_model.dart';
import 'package:tikusevents/registration/screens/events_detail.dart';
import 'package:tikusevents/registration/screens/events_list.dart';
import 'package:tikusevents/registration/screens/register_screens.dart';

class RegisterRoutes{
  static Route generateRoute(RouteSettings settings){

    if(settings.name == "/"){
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
      RegisterModel registerModel = settings.arguments;
      return MaterialPageRoute(builder: (context) => RegisterDetail(registerModel: registerModel,));
    }

  }
}