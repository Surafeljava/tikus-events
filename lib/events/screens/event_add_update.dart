import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tikusevents/events/bloc/bloc.dart';
import 'package:tikusevents/events/models/event_argument.dart';
import 'package:tikusevents/events/models/my_event_model.dart';
import 'package:http/http.dart' as http;

class EventAddUpdate extends StatefulWidget {

  static final routeName = "/event/addUpdate";

  final EventArgument args;

  EventAddUpdate({this.args});

  @override
  _EventAddUpdateState createState() => _EventAddUpdateState();
}

class _EventAddUpdateState extends State<EventAddUpdate> {

  File _image;
  final picker = ImagePicker();
  bool imageGetClicked = false;

  final GlobalKey<ScaffoldState> _addscaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  int seatsReserved = 0;
  MyEventModel myEvent;

  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController seatsController = new TextEditingController();

  DateTime begins = DateTime.now();
  DateTime ends = DateTime.now();
  DateTime deadLine = DateTime.now();

  @override
  void initState() {
    myEvent = widget.args.edit ? widget.args.myEventModel : null;
    seatsReserved = widget.args.edit ? widget.args.myEventModel.reservedSeats : 0;
    if(widget.args.edit){

      List<String> bg = widget.args.myEventModel.eventBeginsOn.split('/');
      begins = DateTime(int.parse(bg[2]), int.parse(bg[1]), int.parse(bg[0]));

      List<String> ed = widget.args.myEventModel.eventEndsOn.split('/');
      begins = DateTime(int.parse(ed[2]), int.parse(ed[1]), int.parse(ed[0]));

      List<String> dl = widget.args.myEventModel.eventDeadline.split('/');
      begins = DateTime(int.parse(dl[2]), int.parse(dl[1]), int.parse(dl[0]));

      titleController.text = widget.args.myEventModel.title;
      descController.text = widget.args.myEventModel.description;
      seatsController.text = (widget.args.myEventModel.allSeats-widget.args.myEventModel.reservedSeats).toString();

    }
    super.initState();
  }

  Future<void> _selectDate(BuildContext context, int which) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != DateTime.now()){
      if(which==0){
        setState(() {
          begins = pickedDate;
        });
      }else if(which==1){
        setState(() {
          ends = pickedDate;
        });
      }else{
        setState(() {
          deadLine = pickedDate;
        });
      }
    }
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
      setState(() {
        imageGetClicked = false;
      });
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _addscaffoldKey,
      appBar: AppBar(
        title: Text(widget.args.edit ? 'Editing' : 'Creating', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w400),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<EventBloc, EventState>(
        listener: (context, state){
          if(state is EventLoading){
            final snackBar = SnackBar(content: Text("Loading..."), duration: Duration(milliseconds: 500),);
            _addscaffoldKey.currentState.showSnackBar(snackBar);
          }else if(state is EventCreateSuccess){
            final snackBar = SnackBar(content: Text('Success!'), duration: Duration(milliseconds: 500),);
            _addscaffoldKey.currentState.showSnackBar(snackBar);
            BlocProvider.of<EventBloc>(context, listen: false).add(EventInitialize());
            Navigator.of(context).pop();
          }else if(state is EventUpdateSuccess){
            final snackBar = SnackBar(content: Text('Success!'), duration: Duration(milliseconds: 500),);
            _addscaffoldKey.currentState.showSnackBar(snackBar);
            BlocProvider.of<EventBloc>(context, listen: false).add(EventInitialize());
            Navigator.of(context).pop();
          }else if(state is EventOperationFailure){
            final snackBar = SnackBar(content: Text(state.failedMessage), duration: Duration(milliseconds: 1000),);
            _addscaffoldKey.currentState.showSnackBar(snackBar);
          }
        },
        builder: (context, state){
          double wd = MediaQuery.of(context).size.width;
          double ht = MediaQuery.of(context).size.height;
          return Container(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    width: wd,
                    height: ht,
                    color: Colors.white,
                    child: ListView(
                      children: [

                        widget.args.edit ? Container() : Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(10.0)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width*0.65,
                              decoration: _image != null ? BoxDecoration(
                                color: Colors.grey[200],
                                image: DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover
                                ),
                              ): BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 65.0,
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                                  ),
                                  child: IconButton(
                                    iconSize: 45,
                                    icon: Icon(Icons.camera_alt, color: Colors.black87),
                                    onPressed: (){
                                      setState(() {
                                        imageGetClicked = true;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            validator: (val) => val.isEmpty ? 'Empty Field' : null,
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 18.0, color: Colors.black, letterSpacing: 0.5,),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                              hintText: 'Title',
                              hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[900],),
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            minLines: 3,
                            maxLines: 5,
                            maxLength: 100,
                            validator: (val) => val.isEmpty ? 'Empty Field' : null,
                            controller: descController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 18.0, color: Colors.black, letterSpacing: 0.5,),
                            onChanged: (val){

                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                              hintText: 'Description',
                              hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[900],),
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            validator: (val) {
                              if(val.isEmpty){
                                return 'Empty Field';
                              }else if(!isNumeric(val)){
                                return 'Not a number';
                              }else{
                                return null;
                              }
                            },
                            controller: seatsController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18.0, color: Colors.black, letterSpacing: 0.5,),
                            onChanged: (val){

                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                              hintText: 'Seats Available (eg. 20)',
                              hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[900],),
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Begins On:', style: TextStyle(fontSize: 17.0, color: Colors.grey[700], letterSpacing: 0.5),), SizedBox(width: 5.0,),
                              Expanded(child: Text('${begins.day}/${begins.month}/${begins.year}', style: TextStyle(fontSize: 17.0, color: Colors.pinkAccent, letterSpacing: 0.5))),
                              IconButton(
                                icon: Icon(Icons.date_range, size: 30.0, color: Colors.pinkAccent,),
                                onPressed: () async{
                                  await _selectDate(context, 0);
                                },
                              ),
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Ends On:', style: TextStyle(fontSize: 17.0, color: Colors.grey[700], letterSpacing: 0.5),), SizedBox(width: 5.0,),
                              Expanded(child: Text('${ends.day}/${ends.month}/${ends.year}', style: TextStyle(fontSize: 17.0, color: Colors.pinkAccent, letterSpacing: 0.5))),
                              IconButton(
                                icon: Icon(Icons.date_range, size: 30.0, color: Colors.pinkAccent,),
                                onPressed: () async{
                                  await _selectDate(context, 1);
                                },
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Deadline', style: TextStyle(fontSize: 17.0, color: Colors.grey[700], letterSpacing: 0.5),), SizedBox(width: 5.0,),
                              Expanded(child: Text('${deadLine.day}/${deadLine.month}/${deadLine.year}' , style: TextStyle(fontSize: 17.0, color: Colors.pinkAccent, letterSpacing: 0.5),)),
                              IconButton(
                                icon: Icon(Icons.date_range, size: 30.0, color: Colors.pinkAccent,),
                                onPressed: () async{
                                  await _selectDate(context, 2);
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15.0,),

                        SpringButton(
                          SpringButtonType.OnlyScale,
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              child: Center(
                                child: Text(widget.args.edit ? 'Update' : 'Create', style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.5),),
                              )
                          ),
                          scaleCoefficient: 0.9,
                          useCache: false,
                          onTap: (){
                            if(_formKey.currentState.validate()){
                              String title = titleController.text;
                              String desc = descController.text;
                              String seats = seatsController.text;

                              DateTime dt = DateTime.now();
                              MyEventModel event = widget.args.edit ? MyEventModel(
                                userId: 0,
                                eventId: widget.args.myEventModel.eventId,
                                title: title,
                                description: desc,
                                eventCreatedOn: widget.args.myEventModel.eventCreatedOn,
                                eventBeginsOn: "${begins.day}/${begins.month}/${begins.year}",
                                eventEndsOn: "${ends.day}/${ends.month}/${ends.year}",
                                eventDeadline: "${deadLine.day}/${deadLine.month}/${deadLine.year}",
                                eventPicture: widget.args.myEventModel.eventPicture,
                                allSeats: int.parse(seats),
                                reservedSeats: widget.args.myEventModel.reservedSeats
                              ) : MyEventModel(
                                  userId: 0,
                                  title: title,
                                  description: desc,
                                  eventCreatedOn: "${dt.day}/${dt.month}/${dt.year}",
                                  eventBeginsOn: "${begins.day}/${begins.month}/${begins.year}",
                                  eventEndsOn: "${ends.day}/${ends.month}/${ends.year}",
                                  eventDeadline: "${deadLine.day}/${deadLine.month}/${deadLine.year}",
                                  eventPicture: "",
                                  allSeats: int.parse(seats),
                                  reservedSeats: 0
                              );

                              if(widget.args.edit){
                                BlocProvider.of<EventBloc>(context, listen: false).add(EventUpdate(event));
                              }else{
                                BlocProvider.of<EventBloc>(context, listen: false).add(EventCreate(event, _image));
                              }

                            }else{
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),


                imageGetClicked ? Container(
                  color: Colors.black54,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      height: MediaQuery.of(context).size.width*0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('From', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: Colors.grey[900]),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 45,
                                    icon: Icon(Icons.camera, color: Colors.orange),
                                    onPressed: () async{
                                      await getImage(ImageSource.camera);
                                    },
                                  ),
                                  Text('Camera', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.grey[800]),),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 45,
                                    icon: Icon(Icons.photo, color: Colors.orange),
                                    onPressed: () async{
                                      await getImage(ImageSource.gallery);
                                    },
                                  ),
                                  Text('Gallery', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.grey[800]),),
                                ],
                              ),
                            ],
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.close),
                            label: Text('Cancel'),
                            onPressed: (){
                              setState(() {
                                imageGetClicked = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Container(),


                state is EventLoading ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.black54
                  ),
                  child: Center(
                    child: SpinKitFadingCircle(
                      size: 35.0,
                      color: Colors.white,
                    ),
                  ),
                ): Container(),

              ],
            ),
          );
        },
      ),
    );
  }
}

