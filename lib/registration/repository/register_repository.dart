
import 'package:tikusevents/registration/data_provider/register_data_provider.dart';
import 'package:tikusevents/registration/models/event_model.dart';
import 'package:tikusevents/registration/models/register_model.dart';

class RegisterRepository{

  final RegisterDataProvider dataProvider;
  RegisterRepository({this.dataProvider});


  Future<List<dynamic>> createRegister(RegisterModel registerModel) async {
    return await dataProvider.createRegister(registerModel);
  }

  Future<List<dynamic>> updateRegisters(RegisterModel registerModel) async {
    return await dataProvider.updateRegister(registerModel);
  }

  Future<List<dynamic>> deleteRegister(RegisterModel registerModel) async {
    return await dataProvider.deleteRegister(registerModel);
  }

  Future<List<dynamic>> getRegisters() async {
    return await dataProvider.getRegisters();
  }

  Future<List<dynamic>> getEvents() async {
    return await dataProvider.getEvents();
  }

}