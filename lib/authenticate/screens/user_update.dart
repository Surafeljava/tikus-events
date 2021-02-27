import 'package:flutter/material.dart';
import 'package:tikusevents/app_route.dart';

class UserUpdate extends StatefulWidget {

  static const routeName = '/auth/user/update';
  final UserRegisterArgument args;

  UserUpdate({this.args});
  @override
  _UserUpdateState createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("GetPicture"),
                onPressed: (){

                },
              ),

              SizedBox(height: 15.0,),

              ElevatedButton(
                child: Text("Update User"),
                onPressed: (){

                },
              )
            ],
          ),
        )
    );
  }
}
