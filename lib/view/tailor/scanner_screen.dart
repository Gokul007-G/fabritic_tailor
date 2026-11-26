import 'package:fabritic/controller/tailorcontroller/view_measurement_controller.dart';
import 'package:fabritic/theme/app_colors.dart';
import 'package:fabritic/widget/qr_scanner_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';

class ScannerScreen extends StatefulWidget {
  final BuildContext context;
  ScannerScreen({super.key, required this.context});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ViewMeasurementController viewMeasurementController =
      Get.find<ViewMeasurementController>();

  final MobileScannerController mobileScannerController =
      MobileScannerController();

  bool isHandle = false;
  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors(context);

    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner'), centerTitle: true),
      body: Center(
        child: Obx(
          () => viewMeasurementController.isLoading.value
              ? const CircularProgressIndicator()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 2, color: colors.black),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(blurStyle: BlurStyle.outer, blurRadius: 15),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Scan QR Code',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: QrScannerWidget(
                                // testMode: true,
                                onScan: (code) async {
                                  await viewMeasurementController
                                      .viewMeasurementCnt(context, code);
                                },
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: colors.error,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
