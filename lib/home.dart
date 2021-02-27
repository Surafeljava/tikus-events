import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tikusevents/events/data_provider/event_data_provider.dart';
import 'package:tikusevents/events/repository/event_repository.dart';
import 'package:tikusevents/registration/data_provider/register_data_provider.dart';
import 'package:tikusevents/registration/repository/register_repository.dart';

class Home extends StatelessWidget {

  final RegisterRepository registerRepository = RegisterRepository(
    dataProvider: RegisterDataProvider(
      httpClient: http.Client(),
    ),
  );

  final EventRepository eventRepository = EventRepository(
    dataProvider: EventDataProvider(
      httpClient: http.Client(),
    ),
  );

  //TODO: Find a way to add the two together

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
