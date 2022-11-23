import 'package:get/get.dart';
import 'package:movies/api_manager/api_config.dart';
import 'package:movies/app_config.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/module/top_movies/provider/top_movies_provider.dart';

class TopMoviesController extends GetxController {
  static TopMoviesController get to => Get.find();

  RxBool isMoviesLoading = false.obs;
  Rxn<MovieList> movies = Rxn<MovieList>();

  Future<void> getMovies() async {
    if (isMoviesLoading.value == true) return;
    isMoviesLoading.value = true;

    await TopMoviesProvider().getAllMovies(
      onSuccess: (response) {
        if (response != null) {
          movies.value = response;
        }
        isMoviesLoading.value = false;
      },
      onError: (String message) {
        isMoviesLoading.value = false;
        Get.showSnackbar(
          const GetSnackBar(title: ApiConfig.error, message: responseMessage),
        );
      },
    );
  }
}
