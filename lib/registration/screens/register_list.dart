import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                      return ListTile(
                        title: Text(events[index].title),
                        subtitle: Text(events[index].description),
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
