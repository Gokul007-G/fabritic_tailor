import 'package:dio/dio.dart';
import 'package:fabritic/model/orders_model.dart';
import 'package:fabritic/services/api_services.dart';

class DashboardService {
  final api = ApiServices();

  // Get job allocation Details
  Future<List<Order>> getOrderSrc(String empName, String branchId) async {
    final response = await api.tailorUrl.post(
      'tailor_dashboard.php',
      data: FormData.fromMap({'emp_name': empName, 'branch_id': branchId}),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      // ✅ Correct comparison
      if (data["status"] == "success") {
        final result = data['data'];
        if (result is List) {
          return result.map((e) => Order.fromJson(e)).toList();
        } else if (result is Map) {
          return [Order.fromJson(result['data'])];
        } else {
          return [];
        }
      } else if (data['status'] == 'error') {
        throw Exception(data['message']);
      } else {
        throw Exception('Unexpected server response');
      }
    } else {
      throw Exception('Server Error');
    }
  }
}
