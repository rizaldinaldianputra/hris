import 'package:dio/dio.dart';
import 'package:hris/models/leave_model.dart';
import 'package:hris/service/common_services.dart';

class LeaveService {
  late CommonService api;
  String url = '/leave';
  String connErr = 'Please check your internet connection and try again';

  LeaveService(context) {
    api = CommonService(context);
  }

  Future<List<LeaveModel>> findAllData(data) async {
    Response response = await api.postHTTP('$url/filtered', data);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data']['content'];
      final result = data.map((json) => LeaveModel.fromJson(json)).toList();
      print(result.length);
      return result;
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<Response> postDataLeave(data) async {
    Response response = await api.postHTTP(url, data);
    return response;
  }
}
