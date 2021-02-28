import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_argument.dart';
import 'package:tikusevents/registration/models/register_model.dart';
import 'package:tikusevents/registration/screens/events_list.dart';

class RegisterAddUpdate extends StatefulWidget {

  static final routeName = '/register/add_update';

  final RegisterArgument args;
  RegisterAddUpdate({this.args});

  @override
  _RegisterAddUpdateState createState() => _RegisterAddUpdateState();
}

class _RegisterAddUpdateState extends State<RegisterAddUpdate> {

  final _formKey = GlobalKey<FormState>();

  int count = 0;

  RegisterModel rModel;
  EventModel eModel;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    setState(() {
      rModel = widget.args.edit ? widget.args.registerModel : null;
      count = widget.args.edit ? rModel.reserved_seats : 0;
      eModel = widget.args.eventModel;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.args.edit ? 'Editing' : 'Registration', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w400),),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.grey[800],
          ),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterInitialize());
              Navigator.of(context).pushNamedAndRemoveUntil(EventsList.routeName, (route) => false);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state){
                if(state is RegisterLoading){
                  final snackBar = SnackBar(content: Text("Loading..."), duration: Duration(milliseconds: 500),);
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }else if(state is RegisterCreateSuccess){
                  final snackBar = SnackBar(content: Text('Updated!'), duration: Duration(milliseconds: 500),);
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                  BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterInitialize());
                  Navigator.of(context).pushNamedAndRemoveUntil(EventsList.routeName, (route) => false);
                }else if(state is RegistrationToEventFailure){
                  final snackBar = SnackBar(content: Text(state.failedMessage), duration: Duration(milliseconds: 1000),);
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                      child: Text('${eModel.title}', style: TextStyle(fontSize: 34.0,color: Colors.grey[800], fontWeight: FontWeight.w700),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                      child: Text('${eModel.description}', style: TextStyle(fontSize: 18.0,color: Colors.grey[800], fontWeight: FontWeight.w400),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Text('Seats Available: ${eModel.allSeats-eModel.reservedSeats}', style: TextStyle(fontSize: 18.0,color: Colors.grey[800], fontWeight: FontWeight.w300),),
                    ),


                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                      child: Text('Number of Seats', style: TextStyle(fontSize: 20.0,color: Colors.grey[800], fontWeight: FontWeight.w300),),
                    ),

                    SizedBox(height: 30.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Icon(Icons.add, color: Colors.grey[800], size: 30.0,),
                          onPressed: (){
                            setState(() {
                              if(!widget.args.edit){
                                if((eModel.allSeats-eModel.reservedSeats)==count){
                                  count = count;
                                }else{
                                  count += 1;
                                }
                              }else{
                                count += 1;
                              }
                            });
                          },
                        ),

                        Text('$count', style: TextStyle(fontSize: 50.0, color: Colors.deepOrangeAccent),),

                        TextButton(
                          child: Icon(Icons.remove, color: Colors.grey[800], size: 30.0,),
                          onPressed: (){
                            setState(() {
                              if(count==1){
                                count = 1;
                              }else{
                                count -= 1;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 30.0,),

                    ElevatedButton(
                      child: Text(widget.args.edit ? "Update" : "Add", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w300),),
                      onPressed: (){
                        print("Seats to be: ${count}");
                        final RegisterEvent event = widget.args.edit ? RegisterUpdate(
                          RegisterModel(
                              reg_id: rModel.reg_id,
                              user_id: rModel.user_id,
                              event_id: rModel.event_id,
                              registered_on: rModel.registered_on,
                              reserved_seats: count
                          ),
                        ) : RegisterCreate(
                          RegisterModel(
                              reg_id: 0,
                              user_id: 0,
                              event_id: eModel.eventId,
                              registered_on: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                              reserved_seats: count
                          ),
                        );
                        BlocProvider.of<RegisterBloc>(context).add(event);
                      },
                    ),

                    Spacer(),

                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
