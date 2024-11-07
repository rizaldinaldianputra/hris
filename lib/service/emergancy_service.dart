import 'package:dio/dio.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/emergency_model.dart';
import 'package:hris/service/common_services.dart';

class EmergancyService {
  late CommonService api;
  late Response response;
  String url = API_URL;
  String connErr = 'Please check your internet connection and try again';

  EmergancyService(context) {
    api = CommonService(context);
  }

  Future<List<EmergencyModel>> listEmergancy() async {
    final response = await api.getHTTP('$url/emergency-contact');

    if (response.statusCode == 200) {
      final data = response.data['data'];

      List<EmergencyModel> attendanceLogs = (data as List).map((item) {
        return EmergencyModel.fromJson(item);
      }).toList();

      return attendanceLogs;
    } else {
      throw Exception('Failed to load attendance logs');
    }
  }
}
