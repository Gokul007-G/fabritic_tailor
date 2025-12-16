import 'dart:developer';

import 'package:fabritic/controller/biometric/biometric_controller.dart';
import 'package:fabritic/controller/login_controller.dart';
import 'package:fabritic/controller/navigation/navigation_controller.dart';
import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/controller/tailorcontroller/dashboard_controller.dart';
import 'package:fabritic/controller/tailorcontroller/view_measurement_controller.dart';
import 'package:fabritic/services/api_services.dart';
import 'package:fabritic/services/login_services.dart';
import 'package:fabritic/services/tailor/dashboard_service.dart';
import 'package:fabritic/services/tailor/view_measurement_services.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    //Services
    Get.put(Service());
    Get.put(LoginServices());
    Get.put(ApiServices());
    Get.put(ViewMeasurementServices());
    Get.put(DashboardService());

    //Controllers
    Get.put(BiometricController());
    Get.put(NavigationController());
    Get.put(StorageController());
    Get.put(DashboardController());
    Get.put(ViewMeasurementController());
    Get.put(LoginController());
  }
}
