import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api_manager/api_config.dart';
import 'package:movies/app_config.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/module/base/provider/base_provider.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();

  late TabController tabController;

  RxInt selectedIndex = 0.obs;

  RxBool isGenresLoading = false.obs;

  Rxn<GenresList> genres = Rxn<GenresList>();

  Future<void> getGenres() async {
    if (isGenresLoading.value == true) return;
    isGenresLoading.value = true;

    await BaseProvider().getAllGenres(
      onSuccess: (response) {
        if (response != null) {
          genres.value = response;
        }
        isGenresLoading.value = false;
      },
      onError: (String message) {
        isGenresLoading.value = false;
        Get.showSnackbar(
          const GetSnackBar(title: ApiConfig.error, message: responseMessage),
        );
      },
    );
  }

  Future<List<Genre>>? getGenreById(List<int> genreIDs, List<Genre> genreList) async {
    List<Genre> _genres = [];
    for (var valueGenre in genreList) {
      for (var genre in genreIDs) {
        if (genre != null && valueGenre != null && valueGenre.id != null) {
          if (valueGenre.id == genre) {
            _genres.add(valueGenre);
          }
        }
      }
    }
    return _genres;
  }
}
