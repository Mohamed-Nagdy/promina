import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:pro_mina_task/app/modules/home/controllers/states/home_gallery_state.dart';
import 'package:pro_mina_task/global/dio/dio_helper.dart';
import 'package:pro_mina_task/global/help_functions/help_functions.dart';
import 'package:pro_mina_task/global/managers/strings_manager.dart';
import 'package:pro_mina_task/global/managers/url_manager.dart';
import 'package:pro_mina_task/global/models/gallery.dart';

class HomeRemoteProvider {
  DioHelper helper = DioHelper();

  Future<HomeState> getGallery() async {
    try {
      final response = await helper.getData(UrlManager.myGalleryEndPoint);
      if (response['status'] == 'success') {
        return HomeSuccessState(GalleryModel.fromJson(response));
      } else {
        showErrorToast(StringsManager.tryAgain);
        return HomeFailedState(StringsManager.tryAgain);
      }
    } catch (e) {
      log(e.toString());
      return HomeFailedState(StringsManager.tryAgain);
    }
  }

  Future<bool> uploadImage(String path) async {
    try {
      showWaitingIndicator(StringsManager.pleaseWait);

      final response = await helper.postData(
        UrlManager.uploadImageEndPoint,
        {
          'img': await d.MultipartFile.fromFile(
            path,
            filename: '${DateTime.now()}.png',
          )
        },
      );

      if (response['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      hideWaitingIndicator();
    }
  }
}
