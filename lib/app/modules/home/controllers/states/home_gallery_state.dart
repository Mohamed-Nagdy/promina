import 'package:pro_mina_task/global/models/gallery.dart';

class HomeState {
  GalleryModel? gallery;
  String? errorMessage;
}

class HomeSuccessState extends HomeState {
  HomeSuccessState(GalleryModel gallery) {
    this.gallery = gallery;
  }
}

class HomeFailedState extends HomeState {
  HomeFailedState(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}

class HomeLoadingState extends HomeState {}
