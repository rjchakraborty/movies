import 'package:get/get.dart';
import 'package:movies/modal_class/movie.dart';

class MovieDetailController extends GetxController {
  static MovieDetailController get to => Get.find();

  Rxn<Movie> selectedMovie = Rxn<Movie>();
  RxBool isDetailPage = false.obs;
  RxInt index = 0.obs;
  RxInt heroID = 0.obs;
}
