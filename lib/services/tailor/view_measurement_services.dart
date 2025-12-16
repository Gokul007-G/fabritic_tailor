import 'package:dio/dio.dart';
import 'package:fabritic/model/measurement_model.dart';
import 'package:fabritic/services/api_services.dart';

class ViewMeasurementServices {
  final api = ApiServices();

  //get a measurement By job id
  Future<Measurement?> viewMeasurementSrc(String jbNo) async {
    final response = await api.tailorUrl.post(
      'view_measurement.php',
      data: FormData.fromMap({'jbNo': jbNo}),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      if (data != null && data != '') {
        if (data['status'] == 'success') {
          return Measurement.fromJson(data['data'][0]);
        } else {
          throw Exception(data['message']);
        }
      } else {
        return null;
      }
    } else {
      throw Exception('Server Error');
    }
  }

  //Update Job Status
  Future<bool> updateJobStatusSrc(String jbNo, String status) async {
    final response = await api.tailorUrl.post(
      'update_status.php',
      data: FormData.fromMap({'jbNo': jbNo, 'status': status}),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
