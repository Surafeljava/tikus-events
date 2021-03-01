
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
    List<dynamic> result = await dataProvider.getRegisters();
    List<RegisterModel> registers = [];
    List<EventModel> events = [];
    if(result[0]){
      registers = result[1];
      for(int i=0; i<registers.length; i++){
        List<dynamic> result2 = await getSingleEvent(registers[i].event_id);
        if(result2[0]){
          EventModel model = result2[1];
          events.add(model);
        }
      }
    }else{
      return [false, result[1]];
    }

    return [true, [events, result[1]]];
  }

  Future<List<dynamic>> getEvents() async {
    return await dataProvider.getEvents();
  }

  Future<List<dynamic>> getSingleEvent(int eventId) async {
    return await dataProvider.getSingleEvent(eventId);
  }

  Future<List<dynamic>> getAdminData() async {
    return await dataProvider.getAdminDashboardData();
  }

}