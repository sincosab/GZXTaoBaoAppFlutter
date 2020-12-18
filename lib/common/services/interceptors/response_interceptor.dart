import 'package:dio/dio.dart';

import '../code.dart';
import '../result_data.dart';

/**
 * Token拦截器
 */
class ResponseInterceptors extends InterceptorsWrapper {

  @override
  onResponse(Response response) {
    RequestOptions option = response.request;
    try {
      if (option.contentType != null && option.contentType.runtimeType == "text") {
       new ResultData(response.data, true, Code.SUCCESS);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
     new ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
     new ResultData(response.data, false, response.statusCode, headers: response.headers);
    }
  }
}