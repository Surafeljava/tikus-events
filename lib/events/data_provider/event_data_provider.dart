import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikusevents/events/models/my_event_model.dart';

class EventDataProvider {
  static final baseUrl = 'http://192.168.137.1:5000';
  final http.Client httpClient;

  EventDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> getTokenFromSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    return token;
  }

  Future<List<dynamic>> getAllEvents() async {
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.get(
      '$baseUrl/event/all/mine',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
    );

    if(response.statusCode == 200){
      List<MyEventModel> eventModels = [];
      Map<String, dynamic> myMap = json.decode(response.body);
      List<dynamic> events = myMap["events"];
      events.forEach((event) {
        eventModels.add(
            MyEventModel.fromJson(event)
        );
      });
      return [true, eventModels];
    }else{
      return [false, 'Error getting events'];
    }
  }

  Future<String> uploadEventProfilePic(File profile) async{

    String name = '';

    var req = http.MultipartRequest('POST', Uri.parse('$baseUrl/event/pic'));
    req.files.add(
        http.MultipartFile(
            'pic',
            File(profile.path).readAsBytes().asStream(),
            File(profile.path).lengthSync(),
            filename: profile.path.split("/").last
        ));

    try{
      var res = await req.send();
      name = await res.stream.transform(utf8.decoder).elementAt(0);
    }catch(e){
      print("//*** Error: $e");
    }

    return name;

  }


  Future<List<dynamic>> createEvent(MyEventModel event, File imageFile) async {

    String rslt = await uploadEventProfilePic(imageFile);
    var data = jsonDecode(rslt);
    String message = data["message"];
    if(message!="success"){
      return null;
    }

    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.post(
      '$baseUrl/event/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
      body: jsonEncode(<String, dynamic>{
        'title': event.title,
        'description': event.description,
        'event_created_on': event.eventCreatedOn,
        'event_begins_on': event.eventBeginsOn,
        'event_ends_on': event.eventEndsOn,
        'event_deadline': event.eventDeadline,
        'event_picture' : data["pic"],
        'all_seats' : event.allSeats,
        'reserved_seats' : event.reservedSeats
      }),
    );

    if(response.statusCode == 200){
      return [true, "Success"];
    }else{
      return [false, 'Failed'];
    }
  }


  Future<List<dynamic>> updateEvent(MyEventModel event) async{
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.put(
      '$baseUrl/event/update',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': tn
      },
      body: jsonEncode(<String, dynamic>{
        'event_id': event.eventId,
        'title': event.title,
        'description': event.description,
        'event_created_on': event.eventCreatedOn,
        'event_begins_on': event.eventBeginsOn,
        'event_ends_on': event.eventEndsOn,
        'event_deadline': event.eventDeadline,
        'event_picture' : event.eventPicture,
        'all_seats' : event.allSeats,
        'reserved_seats' : event.reservedSeats
      }),
    );

    if (response.statusCode == 200) {
      return [true, 'Success'];
    } else {
      return [false, 'Error Updating event'];
    }
  }


  Future<List<dynamic>> deleteEvent(MyEventModel eventModel) async{
    String tn = await getTokenFromSharedPreference();
    final response = await httpClient.delete(
      '$baseUrl/event/delete?event_id=${eventModel.eventId}',
      headers: <String, String>{
        'token': tn
      },
    );

    if (response.statusCode == 200) {
      return [true, "Success"];
    } else {
      return [true, 'Error Deleting registration'];
    }
  }


}
