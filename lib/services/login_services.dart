import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fabritic/model/user_model.dart';
import 'package:fabritic/services/api_services.dart';

class LoginServices {
  final api = ApiServices();

  Future<User?> login(String mobileNo, String password) async {
    try {
      final response = await api.dio.post(
        'login.php',
        data: FormData.fromMap({
          'mobile_number': mobileNo,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        // print('${jsonDecode(response.data['status'])}');
        // final data = response.data;

        if (data == null) {
          throw Exception('⚠️ No Data Found.');
        }
        if (data['status'] == 'success') {
          return User.fromJson(data['data']);
        } else if (data['status'] == 'error') {
          throw Exception(
            data['message'] ?? 'Enter correct mobile number and password',
          );
        } else {
          throw Exception('Unexpected server response');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('⚠️ Unable to reach server. Check your network.');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('⏳ Server is taking too long to respond.');
      } else {
        throw Exception('Unexpected Dio error: ${e.message}');
      }
    } catch (e) {
      return null;
    }
  }
}
