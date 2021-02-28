import 'package:equatable/equatable.dart';
import 'package:tikusevents/events/models/my_event_model.dart';
import 'package:tikusevents/registration/models/event_model.dart';

class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventLoading extends EventState{}

class EventInitialized extends EventState {
  final List<MyEventModel> events;

  EventInitialized({this.events});

  @override
  List<Object> get props => [events];
}

class EventOperationFailure extends EventState {

  final String failedMessage;
  EventOperationFailure({this.failedMessage});

  @override
  List<Object> get props => [failedMessage];

}

class EventDeleteSuccess extends EventState{}
class EventCreateSuccess extends EventState{}
class EventUpdateSuccess extends EventState{}