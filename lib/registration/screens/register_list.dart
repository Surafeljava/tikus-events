import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/models.dart';
import 'package:tikusevents/registration/screens/register_add_update.dart';
import 'package:tikusevents/registration/screens/register_detail.dart';

class RegisterList extends StatefulWidget {

  static final routeName = '/register/register_list';

  @override
  _RegisterListState createState() => _RegisterListState();
}

class _RegisterListState extends State<RegisterList> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          title: Text('Registered Events'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterInitialize());
              Navigator.of(context).pop();
            },
          ),
        ),
        key: _scaffoldKey,
        body: Container(
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state){
              if(state is RegisterLoading){
                final snackBar = SnackBar(content: Text("Loading..."), duration: Duration(milliseconds: 500),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }else if(state is RegisterGetSuccessful){
                final snackBar = SnackBar(content: Text('Success!'), duration: Duration(milliseconds: 500),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }else if(state is AllRegisterGetFailure){
                final snackBar = SnackBar(content: Text(state.message), duration: Duration(milliseconds: 1000),);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }
            },
            builder: (context, state){
              if(state is RegisterGetSuccessful){
                List<EventModel> events = state.props[0];
                List<RegisterModel> registers = state.props[1];
                if(events.length==0){
                  return Center(
                    child: Text('No Events Yet'),
                  );
                }else{
                  return ListView.builder(
                    itemCount: events.length,
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
                                            Text(events[index].description, style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w300),),
                                          ],
                                        ),

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text((registers[index].reserved_seats).toString(), style: TextStyle(color: Colors.white, fontSize: 36.0, fontWeight: FontWeight.w700),),
                                              Text('Seats Reserved', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w300),),
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
                          Navigator.of(context).pushNamed(RegisterDetail.routeName, arguments: [registers[index], events[index]]);
                        },
                      );
                    },
                  );
                }
              }else if(state is AllRegisterGetFailure){
                return Center(
                  child: IconButton(
                    icon: Icon(Icons.refresh, color: Colors.deepOrange,),
                    onPressed: (){
                      BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterGetAll());
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
        )
      ),
    );
  }
}
