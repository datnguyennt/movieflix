import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Di;
import 'package:movie_flix/util/common/global.dart';

import '../models/common/response_model.dart';
import '/util/common/common.dart';
import '/util/constants/locale_keys.dart';
import 'url_api.dart';

abstract class Constants {
  static const contentType = "application/json";
}

enum MethodType { GET, POST, PATCH, DELETE }

Map<MethodType, String> methods = {
  MethodType.GET: "GET",
  MethodType.POST: "POST",
};

class BaseRequest {
  Dio _dio = Dio();
  Dio _dioFormData = Dio();

  BaseRequest({String? base}) {
    base ??= appEnvironment.domainApi;
    _dio = Dio(
      BaseOptions(
        baseUrl: base,
        receiveTimeout: appEnvironment.receiveTimeout,
        connectTimeout: appEnvironment.connectTimeout,
        contentType: Constants.contentType,
      ),
    );
    _dioFormData = Dio(
      BaseOptions(
        receiveTimeout: appEnvironment.receiveTimeout,
        connectTimeout: appEnvironment.connectTimeout,
        contentType: Constants.contentType,
      ),
    );
  }

  Future<ResponseModel> requestBearerApi({
    required MethodType method,
    required String url,
    Map<String, dynamic>? param,
    Map<String, dynamic>? header,
  }) async {
    Logger.info("URL: " + url + "\n");
    Logger.debug("body: " + param.toString());
    header ??= {};
    header["Authorization"] = 'Bearer '+
    Global.accessToken;
    try {
      var response = await _dio.request(
        url,
        data: param,
        options: Options(method: methods[method], headers: header),
      );
      Logger.debug("Response: " + response.toString());
      return ResponseModel.fromJson(response.data);
    } catch (e) {
      Logger.error(e.toString());

      return handleErrorChat(e);
    }
  }

  Future<ResponseModel> handleErrorChat(dynamic error) async {
    try {
      ResponseModel errorModel = ResponseModel();
      errorModel.error?.message = error.toString();
      if (error is String) {
        errorModel.error?.errors?.first.domain = "html";
        return errorModel;
      }
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.sendTimeout:
            errorModel.error?.message = LocaleKeys.request_send_timeout;
            break;
          case DioErrorType.connectTimeout:
            errorModel.error?.message = LocaleKeys.request_connect_timeout;
            break;
          case DioErrorType.receiveTimeout:
            errorModel.error?.message = LocaleKeys.request_receive_timeout;
            break;
          case DioErrorType.cancel:
            errorModel.error?.message = LocaleKeys.request_cancelled;
            break;
          case DioErrorType.other:
            errorModel.error?.message = LocaleKeys.no_internet;
            break;
          case DioErrorType.response:
            errorModel.error?.message =
                error.response!.statusCode.toString();
        }
      }
      // if (errorModel.code == 401) {
      //   CommonUtil.showToast("Lỗi!");
      // }
      return errorModel;
    } catch (e) {
      return ResponseModel();
    }
  }
}
