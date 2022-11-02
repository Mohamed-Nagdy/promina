import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_mina_task/app/modules/login/controllers/states/login_states.dart';
import 'package:pro_mina_task/app/modules/login/provider/login_remote_provider.dart';
import 'package:pro_mina_task/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final loginstate = LoginState().obs;

  LoginRemoteProvider remoteProvider = LoginRemoteProvider();

  void login() async {
    if (formKey.currentState!.validate()) {
      // set login state to loading
      loginstate.value = LoginLoadingState();
      update();

      // run login provider and update our state
      loginstate.value = await remoteProvider.login(email.text, password.text);
      update();

      // check if our state is success we goto home page
      if (loginstate.value is LoginSuccessState) {
        Get.offAllNamed(Routes.HOME);
      }
    }
  }
}
