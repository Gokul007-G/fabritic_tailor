import 'package:fabritic/model/measurement_model.dart';
import 'package:fabritic/services/services.dart';
import 'package:fabritic/services/tailor/view_measurement_services.dart';
import 'package:fabritic/theme/app_colors.dart';
import 'package:fabritic/view/tailor/dashboard_screen.dart';
import 'package:fabritic/view/tailor/view_measurement_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewMeasurementController extends GetxController {
  //services
  final services = Get.put(ViewMeasurementServices());
  final Services checkServices = Get.put(Services());

  //variables
  final measurement = Measurement().obs;
  final isLoading = false.obs;
  final stitchLoading = false.obs;

  //Images to Store
  List<String> designImages = [];
  List<String> materialImages = [];

  //get measurements by JB Id
  Future<void> viewMeasurementCnt(BuildContext context, String jbNo) async {
    final color = AppColors(context);
    if (isLoading.value) return;
    isLoading.value = true;
    //Check server connection
    bool serverConnect = await checkServices.checkServer(context);
    if (serverConnect) {
      final data = await services.viewMeasurementSrc(jbNo);
      if (data != null) {
        measurement.value = data;
        processedImage(data);
        Get.to(() => ViewMeasurementScreen());
      } else {
        isLoading.value = false;
        Get.defaultDialog(
          title: 'QR Code Not Found',
          titleStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color.error,
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: Text(
              'This QR code has already been completed. Please scan a valid one.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          textConfirm: 'OK',
          confirmTextColor: color.white,
          buttonColor: color.primary,
          radius: 15,
          onConfirm: () {
            Get.offAll(() => DashBoardScreen());
          },
          onWillPop: () async {
            Get.offAll(() => DashBoardScreen());
            return false;
          },
        );
      }
    }
    isLoading.value = false;
  }

  void processedImage(Measurement data) {
    designImages = (data.designImage ?? '')
        .split(',')
        .where((e) => e.trim().isNotEmpty)
        .toList();
    materialImages = (data.image ?? '')
        .split(',')
        .where((e) => e.trim().isNotEmpty)
        .toList();
  }

  //Update Job Status
  Future<bool> updateJobStatusCnt(
    BuildContext context,
    String jbNo,
    String status,
  ) async {
    if (stitchLoading.value) return false;
    stitchLoading.value = true;
    //Check server connection
    bool serverConnect = await checkServices.checkServer(context);

    if (serverConnect) {
      final result = await services.updateJobStatusSrc(jbNo, status);
      stitchLoading.value = false;
      return result;
    } else {
      stitchLoading.value = false;
      return false;
    }
  }
}
