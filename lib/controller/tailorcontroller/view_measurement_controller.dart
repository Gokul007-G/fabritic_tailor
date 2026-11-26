import 'package:fabritic/controller/storage/storage_controller.dart';
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

  final StorageController storageController = Get.find<StorageController>();

  //variables
  final measurement = Measurement().obs;
  final isLoading = false.obs;
  final stitchLoading = false.obs;

  //Images to Store
  List<String> designImages = [];
  List<String> materialImages = [];

  //get measurements by JB Id
  Future<void> viewMeasurementCnt(BuildContext context, String jbNo) async {
    // final color = AppColors(context);
    final empName = storageController.name.value;
    if (isLoading.value) return;
    isLoading.value = true;
    //Check server connection
    bool serverConnect = await checkServices.checkServer(context);
    if (serverConnect) {
      try {
        final data = await services.viewMeasurementSrc(empName, jbNo);
        if (data != null) {
          measurement.value = data;
          processedImage(data);
          Get.to(() => ViewMeasurementScreen());
        }
      } catch (e) {
        isLoading.value = false;
        final errorMessage = e.toString().replaceFirst('Exception: ', '');

        String title = 'Error';
        String message = errorMessage;

        if (errorMessage.contains('allocated')) {
          title = 'Access Denied';
          message = 'This job is not allocated to you.';
        } else if (errorMessage.contains('completed')) {
          title = 'Already Completed';
          message =
              'This QR code has already been completed. Please scan a valid one.';
        } else if (errorMessage.contains('QR')) {
          title = 'QR Code Not Found';
          message = 'Please scan a valid QR code.';
        }
        Get.defaultDialog(
          barrierDismissible: false,
          title: '',
          contentPadding: const EdgeInsets.all(20),
          radius: 22,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔴 Icon
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),

              const SizedBox(height: 20),

              // 🔴 Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              // 🔴 Message
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 24),

              // ✅ Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => DashBoardScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
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
