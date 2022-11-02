import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_mina_task/global/managers/assets_manager.dart';
import 'package:pro_mina_task/global/managers/colors_manager.dart';
import 'package:pro_mina_task/global/managers/fonts_manager.dart';
import 'package:pro_mina_task/global/managers/strings_manager.dart';
import 'package:pro_mina_task/global/managers/values_manager.dart';
import 'package:pro_mina_task/global/widgets/custom_form_field.dart';
import 'package:pro_mina_task/global/widgets/cutom_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Form(
        key: controller.formKey,
        child: Scaffold(
          body: Container(
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetsManager.loginBackground,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringsManager.myGallery,
                  textAlign: TextAlign.center,
                  style: FontsManager.hugeText(
                    ColorsManager.textColor,
                    FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: HeightManager.h40,
                ),
                BlurryContainer(
                  blur: 5,
                  width: WidthManager.w350,
                  height: HeightManager.h400,
                  color: ColorsManager.white.withOpacity(0.4),
                  padding: EdgeInsets.all(PaddingManager.p10),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(SizeManager.s32),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        StringsManager.login,
                        style: FontsManager.hugeText(
                          ColorsManager.textColor,
                          FontWeight.bold,
                        ),
                      ),
                      CustomFormField(
                        hint: StringsManager.email,
                        controller: controller.email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return StringsManager.pleaseInsertYourEmail;
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomFormField(
                        hint: StringsManager.password,
                        controller: controller.password,
                        isSecure: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return StringsManager.pleaseInsertYourPassword;
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomButton(
                        onTap: controller.login,
                        title: StringsManager.submit,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
