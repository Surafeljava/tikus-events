import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/auth/bloc/auth_bloc.dart';
import 'package:tikusevents/auth/bloc/auth_event.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: ElevatedButton(
              child: Text('logout'),
              onPressed: () {
                authenticationBloc.add(LoggedOut());
              },
            )),
      ),
    );
  }
}