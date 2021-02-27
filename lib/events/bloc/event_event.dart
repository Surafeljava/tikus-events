import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class EventInitialize extends EventEvent{

  @override
  List<Object> get props => [];

}