import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fabritic/services/services.dart';

class ApiServices {
  //server
  static const imageUrl = Services.imageUrl;
  static const baseUrl = Services.baseUrl;

  //localhost
  // static const imageUrl = "http://10.0.2.2/SRSSilk/";
  // static const baseUrl = "http://10.0.2.2/SRSSilk/mobile_services/";

  static const tailorBaseUrl = '$baseUrl/tailor/';

  final Dio image = Dio(BaseOptions(baseUrl: imageUrl));
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
  final Dio tailorUrl = Dio(BaseOptions(baseUrl: tailorBaseUrl));
}
