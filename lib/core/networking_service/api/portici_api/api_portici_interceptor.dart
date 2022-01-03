import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentication/portici_authentication_provider.dart';
import 'package:project_model/core/networking_service/api/portici_api/provider/api_service.dart';

class PorticiApiInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      // ignore: avoid_renaming_method_parameters
      RequestOptions request,
      RequestInterceptorHandler handler) async {
    log('REQUEST[${request.method}] => PATH: ${request.path}');

    final String? accessToken = await PorticiAutenticationProvider
        .porticiAuthenticationProvider.getAccessToken;

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    log('HEADERS : ${request.headers}');

    return super.onRequest(request, handler);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log('RESPONSE[${response.statusCode}] => BODY: ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      if (err.requestOptions.headers['Authorization'] != null) {
        final bool refreshtokenIsUpdated = await PorticiAutenticationProvider
            .porticiAuthenticationProvider
            .refreshToken();
        if (refreshtokenIsUpdated) {
          return await _retryRequest(err.requestOptions);
        }
      }
    }

    return super.onError(err, handler);
  }

  Future<dynamic> _retryRequest(RequestOptions requestOptions) async {
    final Options options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return ApiServiceProvider.apiServiceProvider.getApiPortici.dio
        .request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
