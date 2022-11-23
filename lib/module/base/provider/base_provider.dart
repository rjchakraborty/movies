import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;
import 'package:movies/api_manager/api_config.dart';
import 'package:movies/api_manager/api_provider.dart';
import 'package:movies/api_manager/api_service_call.dart';
import 'package:movies/app_config.dart';
import 'package:movies/modal_class/genres.dart';

class BaseProvider {
  Future<void> getAllGenres({
    required Function(GenresList) onSuccess,
    required Function(String error) onError,
  }) async {
    Map<String, dynamic> headerParameters = {};

    final requestBody = {};

    if (kDebugMode) {
      print(headerParameters);
      print(requestBody);
    }

    try {
      final response = await APIProvider.getDio().get(
        AppConfig.genresUrl(),
        options: Options(headers: headerParameters),
        queryParameters: {},
      );
      if (kDebugMode) {
        print(response.requestOptions.uri);
        printLog(response);
      }

      final result = GenresList.fromJson(response.data);
      if (result != null) {
        onSuccess(result);
      } else {
        getX.Get.showSnackbar(
          const getX.GetSnackBar(title: ApiConfig.error, message: interNetMessage),
        );
      }
    } on DioError catch (dioError) {
      dioErrorCall(
        dioError: dioError,
        onCallBack: (String message, bool isRecallError) {
          onError(message);
        },
      );
    }
  }
}
