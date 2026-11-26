import 'package:dio/dio.dart';
import 'package:fabritic/model/orders_model.dart';
import 'package:fabritic/services/api_services.dart';
import 'package:intl/intl.dart';

class DashboardService {
  final api = ApiServices();

  // Get job allocation Details
  Future<List<Order>> getOrderSrc(
    String empName,
    String branchId,
    DateTime fromDate,
    DateTime toDate,
  ) async {
    final formattedFromDate = DateFormat('yyyy-MM-dd').format(fromDate);
    final formattedToDate = DateFormat('yyyy-MM-dd').format(toDate);
    final response = await api.tailorUrl.post(
      'tailor_dashboard.php',
      data: FormData.fromMap({
        'emp_name': empName,
        'branch_id': branchId,
        'fromDate': formattedFromDate,
        'toDate': formattedToDate,
      }),
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
        return [];
        // throw Exception(data['status']);
      } else {
        throw Exception('Unexpected server response');
      }
    } else {
      throw Exception('Server Error');
    }
  }
}
