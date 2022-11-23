import 'package:get/get.dart';
import 'package:movies/controller/general_controller.dart';
import 'package:movies/module/base/provider/base_controller.dart';
import 'package:movies/module/details/provider/movie_detail_controller.dart';
import 'package:movies/module/top_movies/provider/top_movies_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<GeneralController>(GeneralController(), permanent: true);
    Get.put<BaseController>(BaseController(), permanent: true);
    Get.put<TopMoviesController>(TopMoviesController(), permanent: true);
    Get.put<MovieDetailController>(MovieDetailController(), permanent: true);
  }
}
