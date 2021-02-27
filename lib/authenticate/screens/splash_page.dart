import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatelessWidget {

  static const routeName = '/auth/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text('Tikus Events', style: TextStyle(fontSize: 30.0, color: Colors.grey[800], fontWeight: FontWeight.w600, letterSpacing: 1.3),),
            Text("Let's celebrate together!", style: TextStyle(fontSize: 17.0, color: Colors.grey[600], fontWeight: FontWeight.w300, letterSpacing: 0.6),),
            SizedBox(height: 15.0,),
            SpinKitFadingCircle(
              color: Colors.redAccent,
              size: 35.0,
            ),

            Spacer(),
            Text("Connecting...", style: TextStyle(fontSize: 17.0, color: Colors.grey[600], fontWeight: FontWeight.w400, letterSpacing: 0.6),),
            SizedBox(height: 10.0,)
          ],
        ),
      ),
    );
  }
}
