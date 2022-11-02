import 'dart:developer';

import 'package:pro_mina_task/app/modules/login/controllers/states/login_states.dart';
import 'package:pro_mina_task/app/modules/login/provider/login_local_provider.dart';
import 'package:pro_mina_task/global/dio/dio_helper.dart';
import 'package:pro_mina_task/global/help_functions/help_functions.dart';
import 'package:pro_mina_task/global/managers/strings_manager.dart';
import 'package:pro_mina_task/global/managers/url_manager.dart';
import 'package:pro_mina_task/global/models/user.dart';

class LoginRemoteProvider {
  DioHelper helper = DioHelper();
  LoginLocalProvider localProvider = LoginLocalProvider();

  Future<LoginState> login(String email, String password) async {
    try {
      // show waiting indicator
      showWaitingIndicator(StringsManager.pleaseWait);

      // send data to login and wait for response
      final response = await helper.postData(UrlManager.loginEndPoint, {
        "email": email,
        "password": password,
      });

      // if response is sucess we return the data and save it to local storage
      if (response['error_message'] == null) {
        localProvider.saveUserData(UserModel.fromJson(response));
        return LoginSuccessState(UserModel.fromJson(response));
      }
      // else we return error and show the error message
      else {
        showErrorToast(response['error_message'] ?? StringsManager.tryAgain);
        return LoginFailedState(
            response['error_message'] ?? StringsManager.tryAgain);
      }
    } catch (e) {
      log(e.toString());
      return LoginFailedState(e.toString());
    } finally {
      hideWaitingIndicator();
    }
  }
}
