import 'package:tikusevents/registration/models/models.dart';

class RegisterArgument{

  final bool edit;
  final RegisterModel registerModel;
  final EventModel eventModel;

  RegisterArgument({this.edit, this.registerModel, this.eventModel});

}