import 'package:project_model/core/storage/secure_storage_tokens_service.dart';
import 'package:project_model/core/storage/secure_storage_user_service.dart';

class SecureStorageService {
  SecureStorageUserService userSecureStorage = SecureStorageUserService();
  SecureStorageTokensService tokensSecureStorage = SecureStorageTokensService();
}
