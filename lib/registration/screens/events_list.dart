import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tikusevents/authenticate/bloc/bloc.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/screens/events_detail.dart';
import 'package:tikusevents/registration/screens/widgets/drawer.dart';

class EventsList extends StatelessWidget {

  static final routeName = '/register/events';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: BlocBuilder<AuthBloc, AuthenticateState>(
            builder: (context, state){
              AuthModel user = state.props[0];
              return MyDrawer(user: user,);
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state){
              if(state is RegisterLoading){
                final snackBar = SnackBar(content: Text("Loading..."));
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }else if(state is EventGetSuccessful){
                final snackBar = SnackBar(content: Text('Success!'), duration: Duration(seconds: 1),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }else if(state is AllEventGetFailure){
                final snackBar = SnackBar(content: Text(state.message), duration: Duration(seconds: 2),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }
            },
            builder: (context, state){
              if(state is EventGetSuccessful){
                List<EventModel> events = state.props[0];
                if(events.length==0){
                  return Center(
                    child: Text('No Events Yet'),
                  );
                }else{
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(events[index].title),
                        subtitle: Text(events[index].description),
                        onTap: (){
                          //Navigate to Event Details page
                          Navigator.of(context).pushNamed(EventsDetail.routeName, arguments: events[index]);
                        },
                      );
                    },
                  );
                }
              }else{
                return Center(
                  child: SpinKitFadingCircle(
                    color: Colors.blueAccent,
                    size: 30.0,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
