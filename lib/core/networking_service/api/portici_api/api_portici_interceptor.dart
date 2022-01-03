import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentiation/portici_authentication_provider.dart';
import 'package:project_model/core/networking_service/api/portici_api/provider/api_service.dart';
import 'package:project_model/core/storage/secure_storage_sevice.dart';

class PorticiApiInterceptors extends Interceptor {
  final SecureStorageService secureStorageService = SecureStorageService();

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
        final bool refreshTokenIsUpdate = await PorticiAutenticationProvider
            .porticiAuthenticationProvider
            .refreshToken();
        if (refreshTokenIsUpdate) {
          return await _retryRequest(err.requestOptions);
        } else {
          PorticiAutenticationProvider.porticiAuthenticationProvider.setAuth =
              false;
        }
      } else {
        PorticiAutenticationProvider.porticiAuthenticationProvider.setAuth =
            false;
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
