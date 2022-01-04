import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_model/core/storage/secure_storage_configurations.dart';
import 'package:project_model/core/user/user.dart';

class SecureStorageUserService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<User?> getUserData() async {
    try {
      final String? userFromDB = await _secureStorage.read(
        key: SecureStorageKeys.DATABASE_KEY_USERDATA,
      );

      if (userFromDB == null) {
        throw Exception('Utente non trovato nel database');
      }

      final Map<String, dynamic> userDataMap = json.decode(userFromDB);

      if (userDataMap == null) {
        throw Exception('errore decodifica utente (json.decode(userFromDB))');
      }

      return User.fromJson(userDataMap);
    } catch (e) {
      log('(getUserData) Errore Lettura dal Database USER DATA - $e');
      return null;
    }
  }

  Future<void> writeUserIntoSecureStorage(User user) async {
    try {
      final Map<String, dynamic> userDataMap = user.toJson();

      final String userDataString = json.encode(userDataMap);

      await _secureStorage.write(
          key: SecureStorageKeys.DATABASE_KEY_USERDATA, value: userDataString);
    } catch (e) {
      log('(writeUserIntoSecureStorage) Impossibile inserire nuovo utente $e');
    }
  }

  Future<void> clearUserIntoSecureStorage() async {
    try {
      await _secureStorage.delete(key: SecureStorageKeys.DATABASE_KEY_USERDATA);
    } catch (e) {
      log('(clearUserIntoSecureStorage) Impossibile cancellare utente $e');
    }
  }
}
