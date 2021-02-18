import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tikusevents/auth/bloc/auth_bloc.dart';
import 'package:tikusevents/auth/bloc/auth_event.dart';

class SplashPage extends StatefulWidget {

  final AuthenticationBloc authenticationBloc;

  SplashPage({@required this.authenticationBloc});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthenticationBloc>().add(AppStarted());
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text('Tikus Events', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700, letterSpacing: 2.5, color: Colors.grey[800]),),
            ),
            Text('Life is an event. Make it \nmemorable.', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: Colors.grey[700]), textAlign: TextAlign.center,),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: SpinKitChasingDots(
                color: Colors.orange,
                size: 50.0,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Loading...', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w300, letterSpacing: 1.5), textAlign: TextAlign.center,),
            ),


          ],
        ),
      ),
    );
  }
}