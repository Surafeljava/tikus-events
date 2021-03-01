import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/models/dashboard_model.dart';

class AdminDashBoard extends StatefulWidget {

  static final routeName = '/admin/dashboard';

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        title: Text('Admin*'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            BlocProvider.of<RegisterBloc>(context, listen: false).add(RegisterInitialize());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state){

        },
        builder: (context, state){

          if(state is AdminDashBoardGetSuccess){
            DashBoardModel dashBoardModel = state.props[0];
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueGrey,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Events', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 25.0),),
                        Text(dashBoardModel.events.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 45.0),)
                      ],
                    ),
                  ),

                  SizedBox(height: 20.0,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.amber,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Users', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w300, fontSize: 25.0),),
                        Text(dashBoardModel.users.toString(), style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 45.0),)
                      ],
                    ),
                  ),

                  SizedBox(height: 20.0,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.redAccent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Registrations', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 25.0),),
                        Text(dashBoardModel.registrations.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 45.0),)
                      ],
                    ),
                  ),


                ],
              ),
            );
          }

          if((state is AdminDashBoardGetFailed) ){
            return Container(
              child: Center(
                child: Text('Failed to get data'),
              ),
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


        },
      )
    );
  }
}
