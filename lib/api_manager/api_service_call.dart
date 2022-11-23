import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getX;
import 'package:movies/api_manager/api_config.dart';
import 'package:movies/api_manager/api_provider.dart';
import 'package:movies/app_config.dart';
import 'package:movies/controller/general_controller.dart';
import 'package:movies/utils/CommonUtils.dart';
import 'package:movies/utils/HexColor.dart';

Map<String, dynamic>? tempParams;
FormData? tempFormData;
String? tempServiceUrl;
Function? tempSuccess;
Function? tempError;
bool? tempIsProgressShow;
bool? isTempFormData;
bool? tempIsLoading;
bool? tempIsFromLogout;
bool? tempIsHideLoader;
String? tempMethodType;
Map<String, dynamic>? headerParameter;

apiServiceCall({
  required Map<String, dynamic> params,
  required String serviceUrl,
  required Function success,
  required Function error,
  required bool isProgressShow,
  required String methodType,
  bool isFromLogout = false,
  bool? isLoading,
  bool? isHideLoader = true,
  FormData? formValues,
  Map<String, dynamic>? headerParameter,
}) async {
  tempParams = params;
  tempServiceUrl = serviceUrl;
  tempSuccess = success;
  tempMethodType = methodType;
  tempError = error;
  tempIsProgressShow = isProgressShow;
  tempIsLoading = isLoading;
  tempIsFromLogout = isFromLogout;
  tempFormData = formValues;
  tempIsHideLoader = isHideLoader;

  if (await checkInternet()) {
    if (tempIsProgressShow != null && tempIsProgressShow!) {
      showProgressDialog();
    }

    if (tempFormData != null) {
      Map<String, dynamic> tempMap = <String, dynamic>{};
      for (var element in tempFormData!.fields) {
        tempMap[element.key] = element.value;
      }
      FormData reGenerateFormData = FormData.fromMap(tempMap);
      for (var element in tempFormData!.files) {
        if (kDebugMode) {
          print(element);
        }
        reGenerateFormData.files.add(MapEntry(element.key, element.value));
      }

      tempFormData = reGenerateFormData;
    }

    Map<String, dynamic> headerParameters = {};

    if (headerParameter != null) {
      headerParameters.addAll(headerParameter);
    }

    try {
      Response response;
      if (tempMethodType == ApiConfig.methodGET) {
        response = await APIProvider.getDio().get(tempServiceUrl!, queryParameters: tempParams, options: Options(headers: headerParameters));
      } else if (tempMethodType == ApiConfig.methodPUT) {
        response = await APIProvider.getDio().put(tempServiceUrl!, data: tempParams, options: Options(headers: headerParameters));
      } else if (tempMethodType == ApiConfig.methodDELETE) {
        response = await APIProvider.getDio().delete(tempServiceUrl!, data: tempParams, options: Options(headers: headerParameters));
      } else {
        response = await APIProvider.getDio().post(tempServiceUrl!, data: tempFormData ?? tempParams, options: Options(headers: headerParameters));
      }
      printRequest(tempParams, isTempFormData);
      if (kDebugMode) {
        print(response.requestOptions.uri);
        print(response.requestOptions.data);
        print(response);
      }

      if (tempIsHideLoader!) {
        hideProgressDialog();
      }

      if (response.statusCode == 404) {
        tempError!("API not found");
      } else {
        tempSuccess!(response);
      }
      GeneralController.to.isLoading.value = false;
      printLog(response);
    } on DioError catch (dioError) {
      dioErrorCall(
          dioError: dioError,
          onCallBack: (String message, bool isRecallError) {
            // showErrorMessage(message: message, isRecall: isRecallError);
          });
      GeneralController.to.isLoading.value = false;
    }
    /*catch (e) {
      hideProgressDialog();
      printMessage("ERROR 123456 ${e.toString()}");
      showErrorMessage(message: e.toString(), isRecall: false);
      GeneralController.to.isLoading.value = false;
    }*/
  } else {
    getX.Get.showSnackbar(
      const getX.GetSnackBar(title: ApiConfig.error, message: interNetMessage),
    );
  }
}

void printMessage(String string) {
  if (kDebugMode) {
    print("PRINT_MESSAGE 123456:=> $string");
  }
}

void printRequest(Map<String, dynamic>? params, bool? data) {
  if (kDebugMode) {
    print("REQUEST ${params.toString()} \n");
    print("REQUEST $data \n");
  }
}

int serviceCallCount = 0;

void showProgressDialog() {
  if (tempIsLoading != null) {
    tempIsLoading = true;
  }
  getX.Get.dialog(
    Center(
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(HexColor.getColor(PRIMARY_COLOR_HEX)),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void hideProgressDialog() {
  if (tempIsLoading != null) {
    tempIsLoading = false;
  }
  if ((tempIsProgressShow! || tempIsHideLoader!) && getX.Get.isDialogOpen!) {
    getX.Get.back();
  }
}

printLog(Response response) {
  if (kDebugMode) {
    print('REQUEST--------> ${response.requestOptions.uri.toString()}');
    print('RESPONSE-------> ${response.data}');
  }
}

dioErrorCall({required DioError dioError, required Function onCallBack}) {
  switch (dioError.type) {
    case DioErrorType.other:
    case DioErrorType.connectTimeout:
      // onCallBack(connectionTimeOutMessage, false);
      onCallBack(dioError.message, true);
      break;
    case DioErrorType.response:
    case DioErrorType.cancel:
    case DioErrorType.receiveTimeout:
    case DioErrorType.sendTimeout:
    default:
      onCallBack(dioError.message, true);
      break;
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

bool handleResponse(Response response) {
  try {
    if (CommonUtils.checkIfNotNull(response.toString())) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
