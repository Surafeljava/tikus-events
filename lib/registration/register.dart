import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/registration/repository/register_repository.dart';
import 'package:tikusevents/registration/screens/register_routes.dart';
import 'bloc/bloc.dart';
import 'screens/register_screens.dart';

class Register extends StatelessWidget{

  final RegisterRepository registerRepository;

  Register({@required this.registerRepository}) : assert(registerRepository != null);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: RepositoryProvider.value(
        value: this.registerRepository,
        child: BlocProvider(
          create: (context) => RegisterBloc(registerRepository: this.registerRepository)..add(RegisterInitialize()),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: RegisterRoutes.generateRoute,
          ),
        ),
      )
    );
  }

}