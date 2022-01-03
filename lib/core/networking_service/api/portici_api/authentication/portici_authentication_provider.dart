import 'package:flutter/material.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentication/portici_authentication_service.dart';
import 'package:project_model/core/storage/secure_storage_configurations.dart';
import 'package:project_model/core/storage/secure_storage_sevice.dart';

class PorticiAutenticationProvider extends ChangeNotifier {
  final PorticiAuthenticationService _porticiAuthService =
      PorticiAuthenticationService();
  final SecureStorageService _secureStorage = SecureStorageService();

  static final PorticiAutenticationProvider porticiAuthenticationProvider =
      PorticiAutenticationProvider();

  bool _isLogged = true;
  bool get getIsLogged => _isLogged;

  set setAuth(bool isLogged) {
    _isLogged = isLogged;
    notifyListeners();
  }

  String? _accessToken;

  Future<String?> get getAccessToken async {
    if (_accessToken == null) {
      _accessToken = await _secureStorage
          .getTokenByKey(SecureStorageKeys.DATABASE_KEY_ACCESSTOKEN);
      return _accessToken;
    }
    return _accessToken;
  }

  set setAccessToken(String? accessToken) => _accessToken = accessToken;

  Future<void> authenticationStatusChange() async =>
      _isLogged ? await logout() : await login();

  Future<void> login() async {
    final loginResponse = await _porticiAuthService.login();
    if (loginResponse.item1) {
      setAccessToken = loginResponse.item2;
      _isLogged = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final bool isNotLogged = await _porticiAuthService.logout();
    if (isNotLogged) {
      setAccessToken = null;

      _isLogged = false;
      notifyListeners();
    }
  }

  Future<bool> refreshToken() async {
    final refreshResponse = await _porticiAuthService.refreshToken();
    if (refreshResponse.item2 != null) {
      setAccessToken = refreshResponse.item2;
    }

    return refreshResponse.item1;
  }
}
