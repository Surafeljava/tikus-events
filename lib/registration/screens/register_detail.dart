import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_argument.dart';
import 'package:tikusevents/registration/models/register_model.dart';

import 'register_screens.dart';

class RegisterDetail extends StatefulWidget {

  static final routeName = '/register/detail';

  final RegisterModel registerModel;
  final EventModel eventModel;

  RegisterDetail({this.registerModel, this.eventModel});

  @override
  _RegisterDetailState createState() => _RegisterDetailState();
}

class _RegisterDetailState extends State<RegisterDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int choice = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${widget.eventModel.title}', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w400),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state){
            if(state is RegisterLoading){
              final snackBar = SnackBar(content: Text("Loading..."), duration: Duration(seconds: 2),);
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }else if(state is RegisterDeleteSuccess){
              final snackBar = SnackBar(content: Text('Success!'), duration: Duration(seconds: 1),);
              _scaffoldKey.currentState.showSnackBar(snackBar);
                BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterGetAll());
                Navigator.pop(context);
            }else if(state is RegisterDeleteFailed){
              final snackBar = SnackBar(content: Text(state.failedMessage), duration: Duration(seconds: 1),);
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width*0.75,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: NetworkImage(widget.eventModel.eventPicture),
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
                              Text('${widget.registerModel.reserved_seats}', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, letterSpacing: 0.75, color: Colors.grey[900]),),
                              SizedBox(width: 5.0,),
                              Text('Seats Reserved', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, letterSpacing: 0.75, color: Colors.grey[900]),),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          child: ElevatedButton(
                            child: Text('Update', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.75, color: Colors.grey[900]),),
                            onPressed: (){
                              Navigator.of(context).pushNamed(RegisterAddUpdate.routeName, arguments: RegisterArgument(edit: true, eventModel: widget.eventModel, registerModel: widget.registerModel));
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
                    child: Text(widget.eventModel.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 1.0),),
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
                    child: Text(widget.eventModel.description, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.grey[800]),),
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
                        Text(widget.eventModel.eventBeginsOn, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.grey[800]),),
                        Spacer(),
                        Text('To'),
                        Spacer(),
                        Text(widget.eventModel.eventEndsOn, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.grey[800]),),
                        Spacer(),
                      ],
                    )
                ),

                Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    child: Text('Delete', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.redAccent),),
                    onPressed: (){
                      //TODO delete here
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Making sure"),
                            content: Text("Are you sure you want to delete this registration?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Delete", style: TextStyle(color: Colors.redAccent),),
                                onPressed: (){
                                  setState(() {
                                    choice = 1;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                      ).then((value) {
                        if(choice==1){
                          BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterDelete(widget.registerModel));
                        }else{
                          setState(() {
                            choice = -1;
                          });
                        }
                      });
                    },
                  )
                ),

                SizedBox(height: 15.0,),


              ],
            );
          }
        ),
      ),
    );
  }
}
