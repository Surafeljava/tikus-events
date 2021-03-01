import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/events/bloc/bloc.dart';
import 'package:tikusevents/events/models/event_argument.dart';
import 'package:tikusevents/events/models/my_event_model.dart';
import 'package:tikusevents/registration/models/event_model.dart';

import 'event_add_update.dart';

class MyEventDetail extends StatelessWidget {

  static final routeName = '/my/event/detail';

  final MyEventModel eventModel;

  MyEventDetail({this.eventModel});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${eventModel.title}', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w400),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        elevation: 0.0,
      ),
      body: BlocConsumer<EventBloc, EventState>(
        listener: (context, state){
          if(state is EventLoading){
            final snackBar = SnackBar(content: Text("Loading..."), duration: Duration(milliseconds: 500),);
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }else if(state is EventDeleteSuccess){
            final snackBar = SnackBar(content: Text('Success!'), duration: Duration(milliseconds: 500),);
            _scaffoldKey.currentState.showSnackBar(snackBar);
            BlocProvider.of<EventBloc>(context, listen: false).add(EventInitialize());
            Navigator.of(context).pop();
          }else if(state is EventOperationFailure){
            final snackBar = SnackBar(content: Text(state.failedMessage), duration: Duration(milliseconds: 1000),);
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }
        },
        builder: (context, snapshot) {
          return Container(
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
                    )
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SpringButton(
                                SpringButtonType.OnlyScale,
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    width: 45,
                                    height: 45,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                    child: Center(
                                      child: Icon(Icons.edit, color: Colors.grey[800],),
                                    ),
                                ),
                                scaleCoefficient: 0.9,
                                useCache: false,
                                onTap: (){
                                  Navigator.of(context).pushNamed(EventAddUpdate.routeName, arguments: EventArgument(edit: true, myEventModel: eventModel));
                                },
                              ),

                              SpringButton(
                                SpringButtonType.OnlyScale,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  width: 45,
                                  height: 45,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                                  child: Center(
                                    child: Icon(Icons.delete, color: Colors.redAccent,),
                                  ),
                                ),
                                scaleCoefficient: 0.9,
                                useCache: false,
                                onTap: (){
                                  BlocProvider.of<EventBloc>(context, listen: false).add(EventDelete(eventModel));
                                },
                              ),

                            ],
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
          );
        }
      ),
    );
  }
}
