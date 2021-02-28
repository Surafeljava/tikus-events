import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/app_route.dart';

import 'authenticate/bloc/bloc.dart';
import 'authenticate/repository/auth_repository.dart';

class Wrapper extends StatelessWidget {

  final AuthRepository authRepository;

  Wrapper({@required this.authRepository}) : assert(authRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.authRepository,
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: this.authRepository)..add(AuthLoad()),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: MaterialApp(
            title: 'Tikus Events',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: AppRoute.generateRoute,
          ),
        ),
      ),
    );
  }
}
