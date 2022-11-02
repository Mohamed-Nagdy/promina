import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina_task/app/modules/home/controllers/states/home_gallery_state.dart';
import 'package:pro_mina_task/app/modules/home/provider/home_remote_provider.dart';
import 'package:pro_mina_task/app/routes/app_pages.dart';
import 'package:pro_mina_task/global/managers/assets_manager.dart';
import 'package:pro_mina_task/global/managers/constant_manager.dart';
import 'package:pro_mina_task/global/managers/storage_manager.dart';
import 'package:pro_mina_task/global/managers/strings_manager.dart';
import 'package:pro_mina_task/global/models/user.dart';
import 'package:pro_mina_task/global/widgets/custom_button_with_icon.dart';

import '../../../../global/managers/colors_manager.dart';
import '../../../../global/managers/fonts_manager.dart';
import '../../../../global/managers/values_manager.dart';
import '../../../../global/models/gallery.dart';

class HomeController extends GetxController {
  late final UserModel user;
  final storage = StorageManager.mainStorage;

  final provider = HomeRemoteProvider();

  final homeState = HomeState().obs;
  final galleryModel = GalleryModel().obs;

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    user = UserModel.fromJson(storage.read(ConstantsManager.userKey));
    getGallery();
  }

  void getGallery() async {
    homeState.value = HomeLoadingState();
    update();

    homeState.value = await provider.getGallery();
    update();

    if (homeState.value is HomeSuccessState) {
      galleryModel.value = homeState.value.gallery!;
      log(galleryModel.value.toJson().toString());
      update();
    }
  }

  void showCustomDialog() {
    Get.dialog(
      Center(
        child: BlurryContainer(
          blur: 5,
          width: WidthManager.w350,
          height: HeightManager.h300,
          color: ColorsManager.white.withOpacity(0.6),
          padding: EdgeInsets.all(PaddingManager.p10),
          borderRadius: const BorderRadius.all(
            Radius.circular(SizeManager.s32),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingManager.p50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButtonWithIcon(
                  style: FontsManager.bigText(
                    ColorsManager.textColor,
                    FontWeight.normal,
                  ),
                  icon: AssetsManager.galleryImage,
                  title: StringsManager.gellary,
                  color: ColorsManager.galleryButtonColor,
                  onTap: () => pickImage(ImageSource.gallery),
                ),
                SizedBox(
                  child: CustomButtonWithIcon(
                    style: FontsManager.bigText(
                      ColorsManager.textColor,
                      FontWeight.normal,
                    ),
                    icon: AssetsManager.cameraImage,
                    title: StringsManager.camera,
                    color: ColorsManager.cameraButtonColor,
                    onTap: () => pickImage(ImageSource.camera),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierColor: Colors.transparent,
    );
  }

  void pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    await uploadImage(image!.path);
    Get.back();
  }

  Future<void> uploadImage(String path) async {
    final response = await provider.uploadImage(path);

    if (response) {
      getGallery();
    }
  }

  void logOut() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
