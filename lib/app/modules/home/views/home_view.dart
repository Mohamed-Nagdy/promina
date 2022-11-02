import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_mina_task/app/modules/home/controllers/states/home_gallery_state.dart';
import 'package:pro_mina_task/global/managers/colors_manager.dart';
import 'package:pro_mina_task/global/managers/fonts_manager.dart';
import 'package:pro_mina_task/global/managers/strings_manager.dart';
import 'package:pro_mina_task/global/managers/values_manager.dart';
import 'package:pro_mina_task/global/widgets/custom_button_with_icon.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../global/managers/assets_manager.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          body: Container(
            width: Get.width,
            padding: EdgeInsets.all(PaddingManager.p15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetsManager.galleryBackground,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringsManager.welcome + controller.user.user!.name!,
                      style: FontsManager.mediumText(
                        ColorsManager.textColor,
                        FontWeight.normal,
                      ),
                    ),
                    const CircleAvatar(
                      radius: SizeManager.s32,
                      backgroundColor: ColorsManager.white,
                      backgroundImage: AssetImage(AssetsManager.userImage),
                    )
                  ],
                ),
                const SizedBox(height: SizeManager.s32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButtonWithIcon(
                      icon: AssetsManager.logoutArrow,
                      title: StringsManager.logout,
                      onTap: controller.logOut,
                      style: FontsManager.regularText(
                        ColorsManager.textColor,
                        FontWeight.normal,
                      ),
                    ),
                    CustomButtonWithIcon(
                      icon: AssetsManager.uploadArrow,
                      title: StringsManager.upload,
                      onTap: controller.showCustomDialog,
                      style: FontsManager.regularText(
                        ColorsManager.textColor,
                        FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.s32),
                Expanded(
                  child: controller.homeState.value is HomeSuccessState
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: SizeManager.s16,
                            crossAxisSpacing: SizeManager.s16,
                          ),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(SizeManager.s22),
                              child: Image.network(
                                controller
                                    .galleryModel.value.data!.images![index],
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          itemCount: controller
                              .galleryModel.value.data!.images!.length,
                        )
                      : controller.homeState.value is HomeFailedState
                          ? Center(
                              child: TextButton(
                                onPressed: controller.getGallery,
                                child: const Text(
                                  StringsManager.failedToLoadImages,
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: SizeManager.s16,
                                crossAxisSpacing: SizeManager.s16,
                              ),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: ColorsManager.lightGrey,
                                  highlightColor: ColorsManager.thinGrey,
                                  child: SizedBox(
                                    height: HeightManager.h100,
                                    width: HeightManager.h100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorsManager.grey,
                                        borderRadius: BorderRadius.circular(
                                            SizeManager.s22),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: 21,
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
