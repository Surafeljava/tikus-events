import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/authenticate/bloc/auth_bloc.dart';
import 'package:tikusevents/authenticate/bloc/auth_event.dart';
import 'package:tikusevents/authenticate/bloc/auth_state.dart';
import 'package:tikusevents/authenticate/models/auth_model.dart';
import 'package:tikusevents/events/event.dart';
import 'package:tikusevents/registration/bloc/bloc.dart';
import 'package:tikusevents/registration/screens/admin_dash_board.dart';

class MyDrawer extends StatelessWidget {

  final AuthModel user;

  MyDrawer({this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250.0,
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(user.profileUrl),
                  fit: BoxFit.cover
              )
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(user.userName, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, letterSpacing: 1.0),),
              ),

              SizedBox(
                height: 10.0,
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: Text('Email', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.grey[500]),),
              ),
              SizedBox(height: 5.0,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(user.email, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, letterSpacing: 0.5),),
              ),

            ],
          ),
        ),

        ListTile(
          leading: Icon(Icons.event_note, color: Colors.grey[800],),
          title: Text('MyEvents', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.grey[800 ]),),
          onTap: (){
            //TODO: change this
            Navigator.of(context).pushNamed(Event.routeName);
          },
        ),

        BlocBuilder<AuthBloc, AuthenticateState>(
          builder: (context, state) {
            if(state is Authenticated){
              AuthModel user = state.props[0];
              return user.admin ? ListTile(
                leading: Icon(Icons.dashboard, color: Colors.grey[800],),
                title: Text('Admin Dashboard', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 1.0, color: Colors.grey[800 ]),),
                onTap: (){
                  BlocProvider.of<RegisterBloc>(context, listen: false).add(AdminDashBoardGet());
                  Navigator.of(context).pushNamed(AdminDashBoard.routeName);
                },
              ) : Container();
            }else{
              return Container();
            }
          }
        ),

        Spacer(),

        ListTile(
          leading: Icon(Icons.logout, color: Colors.deepOrangeAccent,),
          title: Text('Logout', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.75, color: Colors.deepOrange),),
          onTap: (){
            BlocProvider.of<AuthBloc>(context, listen: false).add(AuthLogout());
          },
        ),

      ],
    );
  }
}
