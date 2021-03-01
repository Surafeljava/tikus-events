import 'package:equatable/equatable.dart';
import 'package:tikusevents/registration/models/register_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterInitialize extends RegisterEvent{
  @override
  List<Object> get props => [];
}

class RegisterCreate extends RegisterEvent {
  final RegisterModel registerModel;

  const RegisterCreate(this.registerModel);

  @override
  List<Object> get props => [registerModel];

  @override
  String toString() => 'Course Created {course: $registerModel}';
}

class RegisterUpdate extends RegisterEvent {
  final RegisterModel registerModel;

  const RegisterUpdate(this.registerModel);

  @override
  List<Object> get props => [registerModel];

  @override
  String toString() => 'Course Updated {course: $registerModel}';
}

class RegisterDelete extends RegisterEvent {
  final RegisterModel registerModel;

  const RegisterDelete(this.registerModel);

  @override
  List<Object> get props => [registerModel];

  @override
  toString() => 'Course Deleted {course: $registerModel}';
}

class RegisterGetAll extends RegisterEvent{

  const RegisterGetAll();

  @override
  List<Object> get props => [];

}

class AdminDashBoardGet extends RegisterEvent{
  @override
  List<Object> get props => [];
}
