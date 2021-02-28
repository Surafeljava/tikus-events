
import 'package:tikusevents/registration/data_provider/register_data_provider.dart';

class RegisterRepository{

  final RegisterDataProvider dataProvider;  
   RegisterRepository({@required this.dataProvider}): assert(dataProvider != null);

  Future<RegisterModel> createRegistor(RegisterModel register) async {
    return await dataProvider.creaateRegistration(register);
  }

  Future<List<RegisterModel>> getRegisteries() async {
    return await dataProvider.getAllRegisters();
  }

  Future<void> updateRegister(RegisterModel register) async {
    await dataProvider.updateRegistration(register);
  }

  Future<void> deleteRegister(int reg_id) async {
    await dataProvider.deleteRegistration(reg_id);
  }
}
