import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/controller/tailorcontroller/dashboard_controller.dart';
import 'package:fabritic/controller/tailorcontroller/view_measurement_controller.dart';
import 'package:fabritic/theme/app_colors.dart';
import 'package:fabritic/view/tailor/dashboard_screen.dart';
import 'package:fabritic/widget/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewMeasurementScreen extends StatelessWidget {
  ViewMeasurementScreen({super.key});
  final controller = Get.put(ViewMeasurementController());
  final storageController = Get.find<StorageController>();
  final dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    final values = controller.measurement.value;
    final colors = AppColors(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => DashBoardScreen());
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Measurements', style: GoogleFonts.poppins()),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.to(() => DashBoardScreen());
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Job Details
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: colors.white,
                        blurRadius: 8,

                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Job Details",
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      _buildRow(context, 'Job Order Number', '${values.jbNo}'),
                      _buildRow(
                        context,
                        'Measurement\ntaken by',
                        '${values.measurementName}',
                      ),
                      _buildRow(
                        context,
                        'Unit Delivery Date',
                        '${values.unitDeliveryDate}',
                      ),
                      _buildRow(context, 'Stitching Type', '${values.type}'),
                    ],
                  ),
                ),
                //Blouse Measurement
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: colors.white,
                        blurRadius: 8,

                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Blouse Measurement",
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      if (values.blouseWaist != 0 && values.blouseWaist != null)
                        _buildRow(
                          context,
                          'Shoulder',
                          values.blouseWaist.toString(),
                        ),
                      if (values.frontLength != 0 && values.frontLength != null)
                        _buildRow(
                          context,
                          'Front Length',
                          values.frontLength.toString(),
                        ),
                      if (values.backLength != 0 && values.backLength != null)
                        _buildRow(
                          context,
                          'Back Length',
                          values.backLength.toString(),
                        ),
                      if (values.sleeveLength != 0 &&
                          values.sleeveLength != null)
                        _buildRow(
                          context,
                          'Sleeve Length',
                          values.sleeveLength.toString(),
                        ),
                      if (values.sleeveLoose != 0 && values.sleeveLoose != null)
                        _buildRow(
                          context,
                          'Sleeve Loose',
                          values.sleeveLoose.toString(),
                        ),
                      if (values.chest != 0 && values.chest != null)
                        _buildRow(context, 'Chest', values.chest.toString()),
                      if (values.upperChest != 0 && values.upperChest != null)
                        _buildRow(
                          context,
                          'UpperChest',
                          values.upperChest.toString(),
                        ),
                      if (values.hip != 0 && values.hip != null)
                        _buildRow(context, 'Hip', values.hip.toString()),
                      if (values.lowerHip != 0 && values.lowerHip != null)
                        _buildRow(
                          context,
                          'LowerHip',
                          values.lowerHip.toString(),
                        ),
                      if (values.frontNeck != 0 && values.frontLength != null)
                        _buildRow(
                          context,
                          'FrontLength',
                          values.frontLength.toString(),
                        ),
                      if (values.backNeck != 0 && values.backNeck != null)
                        _buildRow(
                          context,
                          'BackNeck',
                          values.backNeck.toString(),
                        ),
                      if (values.armHole != 0 && values.armHole != null)
                        _buildRow(
                          context,
                          'ArmHole',
                          values.armHole.toString(),
                        ),
                      if (values.innerSize != 0 && values.innerSize != null)
                        _buildRow(
                          context,
                          'InnerSize',
                          values.innerSize.toString(),
                        ),
                      if (values.innerModel != 0 && values.innerModel != null)
                        _buildRow(
                          context,
                          'InnerModel',
                          values.innerModel.toString(),
                        ),
                      if (values.shoulderToApex != 0 &&
                          values.shoulderToApex != null)
                        _buildRow(
                          context,
                          'ShoulderToApex',
                          values.shoulderToApex.toString(),
                        ),
                      if (values.dotToDot != 0 && values.dotToDot != null)
                        _buildRow(
                          context,
                          'dotToDot',
                          values.dotToDot.toString(),
                        ),
                    ],
                  ),
                ),
                //Saree Measurement
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: colors.white,
                        blurRadius: 8,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Saree Measurement",
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      if (values.sareeWaist != 0 && values.sareeWaist != null)
                        _buildRow(
                          context,
                          'Waist',
                          values.sareeWaist.toString(),
                        ),
                      if (values.seat != 0 && values.seat != null)
                        _buildRow(context, 'Seat', values.seat.toString()),
                      if (values.waistFloorFront != 0 &&
                          values.waistFloorFront != null)
                        _buildRow(
                          context,
                          'Waist Floor Front',
                          values.waistFloorFront.toString(),
                        ),
                      if (values.waistFloorBack != 0 &&
                          values.waistFloorBack != null)
                        _buildRow(
                          context,
                          'Waist Floor Back',
                          values.waistFloorBack.toString(),
                        ),
                      if (values.shoulderToWaist != 0 &&
                          values.shoulderToWaist != null)
                        _buildRow(
                          context,
                          'Shoulder To Apex',
                          values.shoulderToApex.toString(),
                        ),
                      if (values.pleatsLength != 0 &&
                          values.pleatsLength != null)
                        _buildRow(
                          context,
                          'Pleats Length',
                          values.pleatsLength.toString(),
                        ),
                      if (values.pleatsBreadth != 0 &&
                          values.pleatsBreadth != null)
                        _buildRow(
                          context,
                          'Pleats Breadth',
                          values.pleatsBreadth.toString(),
                        ),
                    ],
                  ),
                ),
                //Other Measurement
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: colors.white,
                        blurRadius: 8,

                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Other Measurement",
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      if (values.waist2 != 0 && values.waist2 != null)
                        _buildRow(context, 'Waist', values.waist2.toString()),
                      if (values.seat2 != 0 && values.seat2 != null)
                        _buildRow(context, 'Seat', values.seat2.toString()),
                      if (values.waistFloor2 != 0 && values.waistFloor2 != null)
                        _buildRow(
                          context,
                          'Waist Floor Front',
                          values.waistFloor2.toString(),
                        ),
                      if (values.thigh != 0 && values.thigh != null)
                        _buildRow(context, 'Thigh', values.thigh.toString()),
                    ],
                  ),
                ),

                //Review
                if (values.remarks != '' || values.generalRemarks != '') ...[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5),
                      boxShadow: [
                        BoxShadow(
                          color: colors.white,
                          blurRadius: 8,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Review",
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        if (values.remarks != '' && values.remarks != null)
                          _buildRow(context, 'Remarks', '${values.remarks}'),
                        if (values.generalRemarks != '' &&
                            values.generalRemarks != null)
                          _buildRow(
                            context,
                            'General Remarks',
                            '${values.generalRemarks}',
                          ),
                      ],
                    ),
                  ),
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.designImages.isNotEmpty) ...[
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Design Model',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      imageSlider(
                        images: controller.designImages,
                        colors: colors,
                      ),
                    ],
                    const SizedBox(height: 10),
                    if (controller.materialImages.isNotEmpty) ...[
                      Text(
                        'Material Image',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      imageSlider(
                        images: controller.materialImages,
                        colors: colors,
                      ),
                    ],
                  ],
                ),
                if (values.status == '0') ...[
                  GestureDetector(
                    onTap: () async {
                      Get.to(() => DashBoardScreen());
                      final result = await controller.updateJobStatusCnt(
                        context,
                        values.jbNo!,
                        '2',
                      );
                      if (result) {
                        dashboardController.getOrdersCnt();
                        Get.snackbar(
                          "Stitching Updated Successfully",
                          "JOB Number - ${values.jbNo} Completed",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: colors.success,
                          colorText: colors.white,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: colors.success,
                        border: Border.all(
                          width: 1,
                          color: colors.white.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: colors.success,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Stitching Completed",
                        style: TextStyle(
                          color: colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            alignment: Alignment.centerLeft,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
