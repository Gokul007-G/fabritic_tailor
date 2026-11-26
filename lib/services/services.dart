import 'package:dio/dio.dart';
import 'package:fabritic/widget/show_error_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Services {
  //localhost
  static const imageUrl = "http://10.0.2.2/SRSSilk/";
  static const baseUrl = "http://10.0.2.2/SRSSilk/mobile_services/";

  //Server
  // static const imageUrl = "https://software.bluebase.in/SRSSilk/";
  // static const baseUrl =
  //     "https://software.bluebase.in/SRSSilk/mobile_services/";

  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  Future<bool> checkServer(BuildContext context) async {
    //Check Internet Connection
    var connectivityResult = await Connectivity().checkConnectivity();
    var hasInternet = await InternetConnectionChecker().hasConnection;

    if (connectivityResult == ConnectivityResult.none || !hasInternet) {
      showErrorDialog(
        context,
        title: 'Internet Not Available',
        message: 'Please check your Wi-Fi or Mobile Data.',
        icon: Icons.wifi_off,
        color: Colors.red,
      );
      return false;
    }
    try {
      Response response = await dio.get(imageUrl);
      if (response.statusCode == 200) {
        return true;
      } else {
        showErrorDialog(
          context,
          title: 'Server Error',
          message: 'Unable to reach the server.',
          icon: Icons.cloud_off,
          color: Colors.orange,
        );
        return false;
      }
    } on DioException catch (e) {
      showErrorDialog(
        context,
        title: 'Server Down',
        message: 'Server is not responding.\n Try again later.',
        icon: Icons.cloud_off,
        color: Colors.orange,
      );
      return false;
    }
  }
}
