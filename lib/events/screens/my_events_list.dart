import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/events/bloc/bloc.dart';
import 'package:tikusevents/events/models/event_argument.dart';
import 'package:tikusevents/events/models/my_event_model.dart';
import 'package:tikusevents/events/screens/event_add_update.dart';
import 'package:tikusevents/events/screens/event_screens.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';

class MyEventList extends StatefulWidget {

  static final routeName = '/my/event/list';

  @override
  _MyEventListState createState() => _MyEventListState();
}

class _MyEventListState extends State<MyEventList> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        title: Text('My Events'),
      ),
      body: BlocConsumer<EventBloc, EventState>(
        listener: (context, state){
          if(state is EventLoading){
            final snackBar = SnackBar(content: Text("Loading..."), duration: Duration(milliseconds: 500),);
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }else if(state is EventGetSuccessful){
            final snackBar = SnackBar(content: Text('Success!'), duration: Duration(milliseconds: 500),);
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }else if(state is EventOperationFailure){
            final snackBar = SnackBar(content: Text(state.failedMessage), duration: Duration(milliseconds: 1000),);
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if(state is EventInitialized){
            List<MyEventModel> myEvents = state.props[0];
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: myEvents.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: ListTile(
                          title: Text(myEvents[index].title),
                          subtitle: Text(myEvents[index].description),
                          onTap: (){
                            Navigator.of(context).pushNamed(MyEventDetail.routeName, arguments: myEvents[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: SpringButton(
                    SpringButtonType.OnlyScale,
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(Icons.add, color: Colors.white,),
                    ),
                    scaleCoefficient: 0.9,
                    useCache: false,
                    onTap: (){
                      Navigator.of(context).pushNamed(EventAddUpdate.routeName, arguments: EventArgument(edit: false, myEventModel: null));
                    },
                  )
                ),
              ],
            );
          }
          else{
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.redAccent,
                size: 30.0,
              ),
            );
          }
        }
      ),
    );
  }
}
