import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/authenticate/bloc/bloc.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/screens/events_detail.dart';
import 'package:tikusevents/registration/screens/register_list.dart';
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.notifications, color: Colors.white,),
          backgroundColor: Colors.grey[900],
          onPressed: (){
            BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterGetAll());
            Navigator.of(context).pushNamed(RegisterList.routeName);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.grey[800],),
              onPressed: (){
                BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterInitialize());
              },
            ),
          ],
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
                final snackBar = SnackBar(content: Text("Loading..."), duration: Duration(seconds: 2),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }else if(state is EventGetSuccessful){
                final snackBar = SnackBar(content: Text('Success!'), duration: Duration(milliseconds: 1),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }else if(state is AllEventGetFailure){
                final snackBar = SnackBar(content: Text(state.message), duration: Duration(milliseconds: 1),);
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
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index){

                      return SpringButton(
                        SpringButtonType.OnlyScale,
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width*0.6,
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(events[index].eventPicture),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(events[index].title, style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w700),),
                                          Text(events[index].description, style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400),),
                                        ],
                                      ),

                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text((events[index].allSeats - events[index].reservedSeats).toString(), style: TextStyle(color: Colors.white, fontSize: 36.0, fontWeight: FontWeight.w700),),
                                            Text('Seats Available', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w300),),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),

                        scaleCoefficient: 0.95,
                        useCache: false,
                        onTap: (){
                          Navigator.of(context).pushNamed(EventsDetail.routeName, arguments: events[index]);
                        },
                      );
                    },
                  );
                }
              }else if(state is AllEventGetFailure){
                return Center(
                  child: IconButton(
                    icon: Icon(Icons.refresh, color: Colors.deepOrange,),
                    onPressed: (){
                      BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterInitialize());
                    },
                  ),
                );
              }else{
                return Center(
                  child: SpinKitFadingCircle(
                    color: Colors.deepOrangeAccent,
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
