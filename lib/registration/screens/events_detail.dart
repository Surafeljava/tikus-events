import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_argument.dart';
import 'package:tikusevents/registration/screens/register_add_update.dart';

class EventsDetail extends StatelessWidget {

  final EventModel eventModel;
  static final routeName = '/register/events/detail';

  EventsDetail({this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${eventModel.title}', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w400),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width*0.75,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                  image: NetworkImage(eventModel.eventPicture),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 35.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${eventModel.allSeats-eventModel.reservedSeats}', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, letterSpacing: 0.75, color: Colors.grey[900]),),
                          SizedBox(width: 5.0,),
                          Text('Seats left!', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, letterSpacing: 0.75, color: Colors.grey[900]),),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      child: ElevatedButton(
                        child: Text('Register Now!', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.75, color: Colors.grey[900]),),
                        onPressed: (){
                          //Do the registration here
                          Navigator.of(context).pushNamed(RegisterAddUpdate.routeName, arguments: RegisterArgument(edit: false, eventModel: eventModel, registerModel: null));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Title', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 1.0, color: Colors.grey[500]),),
              ),
            ),
            SizedBox(height: 2.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(eventModel.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 1.0),),
              ),
            ),

            SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Description', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.grey[500]),),
              ),
            ),
            SizedBox(height: 2.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(eventModel.description, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.grey[800]),),
              ),
            ),

            SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Date', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.grey[500]),),
              ),
            ),
            SizedBox(height: 2.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(eventModel.eventBeginsOn, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.grey[800]),),
                  Spacer(),
                  Text('To'),
                  Spacer(),
                  Text(eventModel.eventEndsOn, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.grey[800]),),
                  Spacer(),
                ],
              )
            ),


          ],
        ),
      ),
    );
  }
}
