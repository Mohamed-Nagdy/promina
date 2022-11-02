import 'package:pro_mina_task/global/managers/constant_manager.dart';
import 'package:pro_mina_task/global/managers/storage_manager.dart';
import 'package:pro_mina_task/global/models/user.dart';

class LoginLocalProvider {
  // get our main storage
  final storage = StorageManager.mainStorage;

  // save user data in local storage and token
  void saveUserData(UserModel user) async {
    await storage.write(ConstantsManager.userKey, user.toJson());
    await storage.write(ConstantsManager.tokenKey, user.token);
  }
}
