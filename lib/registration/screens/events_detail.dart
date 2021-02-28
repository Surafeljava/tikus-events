import 'package:flutter/material.dart';
import 'package:tikusevents/registration/models/event_model.dart';

class EventsDetail extends StatelessWidget {

  final EventModel eventModel;
  static final routeName = '/register/events/detail';

  EventsDetail({this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Register Now!', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.75, color: Colors.grey[900]),),
                  onPressed: (){
                    //Do the registration here

                  },
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
