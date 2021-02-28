import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_argument.dart';
import 'package:tikusevents/registration/models/register_model.dart';

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

  @override
  void initState() {
    setState(() {
      rModel = widget.args.edit ? widget.args.model : null;
      count = widget.args.edit ? rModel.reserved_seats : 0;
      eModel = !widget.args.edit ? widget.args.model : null;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.edit ? 'Editing' : 'Registration', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w400),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Spacer(),

              !widget.args.edit ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                child: Text('${eModel.title}', style: TextStyle(fontSize: 34.0,color: Colors.grey[800], fontWeight: FontWeight.w700),),
              ) : Container(),

              !widget.args.edit ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                child: Text('${eModel.description}', style: TextStyle(fontSize: 18.0,color: Colors.grey[800], fontWeight: FontWeight.w400),),
              ) : Container(),

              !widget.args.edit ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text('Seats Available: ${eModel.allSeats-eModel.reservedSeats}', style: TextStyle(fontSize: 18.0,color: Colors.grey[800], fontWeight: FontWeight.w300),),
              ) : Container(),


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
                        if(count==0){
                          count = 0;
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
                        user_id: 1,
                        event_id: eModel.eventId,
                        registered_on: DateTime.now().toIso8601String(),
                        reserved_seats: count
                    ),
                  );
                  BlocProvider.of<RegisterBloc>(context).add(event);
                  Navigator.of(context).pop();
                },
              ),

              Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}
