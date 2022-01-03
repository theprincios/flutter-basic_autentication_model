import 'package:project_model/core/networking_service/api/portici_api/api_portici_service.dart';

class ApiServiceProvider {
  static final ApiServiceProvider apiServiceProvider = ApiServiceProvider();

  final ApiPorticiService _apiPortici = ApiPorticiService();
  ApiPorticiService get getApiPortici => _apiPortici;
}
