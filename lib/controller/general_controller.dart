import 'package:get/get.dart';

class GeneralController extends GetxController {
  static GeneralController get to => Get.find(); // add this

  ///ManageLoading
  RxBool isLoading = false.obs;

  RxBool isDarkMode = false.obs;
}
