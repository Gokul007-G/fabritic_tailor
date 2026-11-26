import 'dart:io';
import 'package:fabritic/controller/navigation/navigation_controller.dart';
import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/controller/tailorcontroller/dashboard_controller.dart';
import 'package:fabritic/controller/tailorcontroller/view_measurement_controller.dart';
import 'package:fabritic/theme/app_colors.dart';
import 'package:fabritic/view/tailor/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

enum MenuAction { selectDate, logout }

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final controller = Get.put(DashboardController());
  final navigationController = Get.put(NavigationController());
  final StorageController storageController = Get.find();
  final ViewMeasurementController viewMeasurementController = Get.put(
    ViewMeasurementController(),
  );

  @override
  Widget build(BuildContext context) {
    final colors = Get.put(AppColors(context));

    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          title: 'Exit App',
          titlePadding: const EdgeInsets.symmetric(vertical: 15),
          content: const Text('Do you really want to close the app?'),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          textConfirm: 'Yes',
          textCancel: 'No',
          cancelTextColor: colors.primary,
          buttonColor: colors.primary,
          onConfirm: () => exit(0),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colors.primary.withOpacity(0.9),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/icons/logo.jpeg'),
            ),
          ),

          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(storageController.name.value),
              Text(
                storageController.number.value,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => ScannerScreen(context: context));
              },
              icon: Icon(Icons.qr_code_scanner),
            ),

            PopupMenuButton<MenuAction>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              icon: Icon(Icons.more_vert),
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.selectDate:
                    controller.selectCurrentMonth();
                  case MenuAction.logout:
                    Get.defaultDialog(
                      title: "Logout",
                      titleStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                      titlePadding: const EdgeInsets.only(top: 20),
                      middleText: "Are you sure you want to logout?",
                      middleTextStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      backgroundColor: Colors.white,
                      radius: 15,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      barrierDismissible: false,
                      confirm: ElevatedButton.icon(
                        onPressed: () async {
                          await storageController.logout();
                          await exit(0);
                          // if (Platform.isAndroid) {
                          //   // SystemNavigator.pop();
                          //   exit(0);
                          // } else if (Platform.isIOS) {
                          //   exit(0);
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                          elevation: 3,
                        ),
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text(
                          "Yes, Logout",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      cancel: OutlinedButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colors.primary, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                        ),
                        icon: Icon(Icons.close, color: colors.primary),
                        label: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16, color: colors.primary),
                        ),
                      ),
                    );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: MenuAction.selectDate,
                  child: Text(
                    controller.showDateSelcter.value
                        ? 'This Month'
                        : 'Select Date',
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text('Logout', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              //Search Box
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.textEditingController,
                  onChanged: (value) => controller.searchQuery.value = value,
                  cursorColor: colors.primary,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    controller.searchQuery.value = '';
                    controller.textEditingController.clear();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search_rounded,
                        color: colors.primary,
                        size: 26,
                      ),
                    ),

                    hintText: 'Search for Name, Invoice or JB No',
                    hintStyle: TextStyle(
                      color: colors.primary.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    fillColor: colors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: colors.primary, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Obx(() {
                final from = DateFormat(
                  'dd MMM yyyy',
                ).format(controller.fromDate.value);
                final to = DateFormat(
                  'dd MMM yyyy',
                ).format(controller.toDate.value);

                return controller.showDateSelcter.value
                    ? Column(
                        children: [
                          Row(
                            children: [
                              // FROM DATE
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => controller.pickDate(
                                    context,
                                    controller.fromDate,
                                  ),
                                  child: _dateBox(
                                    icon: Icons.calendar_today,
                                    label: 'From',
                                    value: from,
                                    colors: colors,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // TO DATE
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => controller.pickDate(
                                    context,
                                    controller.toDate,
                                  ),
                                  child: _dateBox(
                                    icon: Icons.calendar_today,
                                    label: 'To',
                                    value: to,
                                    colors: colors,
                                  ),
                                ),
                              ),
                              controller.isLoading.value
                                  ? Container(
                                      width: 18,
                                      height: 18,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: const CircularProgressIndicator(),
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        await controller.getOrdersCnt();
                                      },
                                      icon: Icon(
                                        Icons.send,
                                        color: colors.primary,
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      )
                    : const SizedBox.shrink();
              }),

              Expanded(
                child: Obx(() {
                  if (controller.filteredOrders.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon container
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: colors.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.inbox_outlined,
                                size: 60,
                                color: colors.primary,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Title
                            Text(
                              controller.pickedDateError.value
                                  ? 'Invalid Date'
                                  : 'No Orders Yet',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 8),

                            // Subtitle
                            Text(
                              controller.pickedDateError.value
                                  ? 'From date cannot be greater than To date.'
                                  : 'Orders will appear here once they are created or assigned.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: controller.isLoading.value
                                    ? SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation(
                                            colors.white,
                                          ),
                                        ),
                                      )
                                    : const Icon(Icons.refresh),
                                label: Text(
                                  controller.isLoading.value
                                      ? 'Refreshing...'
                                      : controller.pickedDateError.value
                                      ? 'Refresh To This Month'
                                      : 'Refresh Orders',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colors.primary,
                                  foregroundColor: colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: controller.isLoading.value ? 0 : 2,
                                ),
                                onPressed: controller.isLoading.value
                                    ? null // 🚫 disables button while loading
                                    : () {
                                        controller.pickedDateError.value
                                            ? controller.selectCurrentMonth()
                                            : controller.getOrdersCnt();
                                      },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (viewMeasurementController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      itemCount: controller.filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = controller.filteredOrders[index];

                        final unitDate = order.unitDeliveryDate
                            .toString()
                            .split(' ')[0];
                        final formattedAllowcateDate = order.date!.split('-');
                        final formattedDeliveryDate = unitDate.split('-');

                        return AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 500),
                          position: index,

                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () async {
                                  controller.searchQuery.value = '';
                                  controller.textEditingController.clear();
                                  await viewMeasurementController
                                      .viewMeasurementCnt(
                                        context,
                                        order.jbNo ?? '',
                                      );
                                  // Get.bottomSheet(
                                  //   Container(
                                  //     height: order.status == 0 ? 300 : 220,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     decoration: BoxDecoration(
                                  //       color: colors.white,
                                  //       borderRadius: BorderRadius.circular(18),
                                  //     ),
                                  //     child: Column(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceEvenly,
                                  //       children: [
                                  //         Column(
                                  //           children: [
                                  //             Padding(
                                  //               padding: const EdgeInsets.all(
                                  //                 8.0,
                                  //               ),
                                  //               child: Text(
                                  //                 '${order.customerName.toString()} - ${order.jbNo.toString()}',
                                  //                 style: TextStyle(
                                  //                   color: colors.black,
                                  //                   fontSize: 16,
                                  //                   fontWeight: FontWeight.bold,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             // View Measurement
                                  //             Obx(
                                  //               () => ElevatedButton(
                                  //                 onPressed: () async {
                                  //                   controller
                                  //                           .searchQuery
                                  //                           .value =
                                  //                       '';
                                  //                   controller
                                  //                       .textEditingController
                                  //                       .clear();
                                  //                   await viewMeasurementController
                                  //                       .viewMeasurementCnt(
                                  //                         context,
                                  //                         order.jbNo ?? '',
                                  //                       );
                                  //                 },
                                  //                 style: ElevatedButton.styleFrom(
                                  //                   backgroundColor: colors
                                  //                       .primary
                                  //                       .withOpacity(0.8),
                                  //                   elevation: 4,
                                  //                   shadowColor: Colors.black26,
                                  //                   shape: RoundedRectangleBorder(
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                           20,
                                  //                         ),
                                  //                   ),
                                  //                   padding:
                                  //                       const EdgeInsets.symmetric(
                                  //                         vertical: 0,
                                  //                       ),
                                  //                 ),
                                  //                 child: Container(
                                  //                   width:
                                  //                       MediaQuery.of(
                                  //                         context,
                                  //                       ).size.width *
                                  //                       0.85,
                                  //                   height: 50,
                                  //                   alignment: Alignment.center,
                                  //                   child: Text(
                                  //                     viewMeasurementController
                                  //                             .isLoading
                                  //                             .value
                                  //                         ? 'Loading...'
                                  //                         : 'View Measurement',
                                  //                     style: TextStyle(
                                  //                       color: colors.white,
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       fontSize: 18,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),

                                  //             const SizedBox(height: 15),

                                  //             if (order.status == 0)
                                  //               // Stitching Completed Button
                                  //               Obx(
                                  //                 () => ElevatedButton(
                                  //                   onPressed: () async {
                                  //                     Get.back();
                                  //                     controller
                                  //                             .searchQuery
                                  //                             .value =
                                  //                         '';
                                  //                     final result =
                                  //                         await viewMeasurementController
                                  //                             .updateJobStatusCnt(
                                  //                               context,
                                  //                               order.jbNo!,
                                  //                               '2',
                                  //                             );
                                  //                     if (result) {
                                  //                       controller.getOrdersCnt(
                                  //                         storageController
                                  //                             .name
                                  //                             .value,
                                  //                         storageController
                                  //                             .branchId
                                  //                             .value,
                                  //                       );
                                  //                       Get.snackbar(
                                  //                         "Stitching Updated Successfully",
                                  //                         "JOB Number - ${order.jbNo} Completed",
                                  //                         snackPosition:
                                  //                             SnackPosition
                                  //                                 .BOTTOM,
                                  //                         backgroundColor:
                                  //                             colors.success,
                                  //                         colorText:
                                  //                             colors.white,
                                  //                       );
                                  //                     }
                                  //                   },
                                  //                   style: ElevatedButton.styleFrom(
                                  //                     backgroundColor: colors
                                  //                         .success
                                  //                         .withOpacity(0.8),
                                  //                     elevation: 4,
                                  //                     shadowColor:
                                  //                         Colors.black26,
                                  //                     shape: RoundedRectangleBorder(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                             20,
                                  //                           ),
                                  //                     ),
                                  //                     padding:
                                  //                         const EdgeInsets.symmetric(
                                  //                           vertical: 0,
                                  //                         ),
                                  //                   ),
                                  //                   child: Container(
                                  //                     width:
                                  //                         MediaQuery.of(
                                  //                           context,
                                  //                         ).size.width *
                                  //                         0.85,
                                  //                     height: 50,
                                  //                     alignment:
                                  //                         Alignment.center,
                                  //                     child: Text(
                                  //                       viewMeasurementController
                                  //                               .stitchLoading
                                  //                               .value
                                  //                           ? 'Loading ...'
                                  //                           : 'Stitching Completed',
                                  //                       style: TextStyle(
                                  //                         color: colors.white,
                                  //                         fontWeight:
                                  //                             FontWeight.bold,
                                  //                         fontSize: 18,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //           ],
                                  //         ),

                                  //         // Cancel Button
                                  //         ElevatedButton(
                                  //           onPressed: () {
                                  //             controller.searchQuery.value = '';
                                  //             Get.back();
                                  //           },
                                  //           style: ElevatedButton.styleFrom(
                                  //             backgroundColor: colors.error,
                                  //             elevation: 4,
                                  //             shadowColor: Colors.black26,
                                  //             shape: RoundedRectangleBorder(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(20),
                                  //             ),
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                   vertical: 0,
                                  //                 ),
                                  //           ),
                                  //           child: Container(
                                  //             width:
                                  //                 MediaQuery.of(
                                  //                   context,
                                  //                 ).size.width *
                                  //                 0.85,
                                  //             height: 50,
                                  //             alignment: Alignment.center,
                                  //             child: Text(
                                  //               'Cancel',
                                  //               style: TextStyle(
                                  //                 color: colors.white,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 18,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: BoxBorder.all(
                                      width: order.status == 2 ? 0 : 1.3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.primary.withOpacity(0.2),
                                        blurRadius: 6,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //Header
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "JOB Number: ${order.jbNo}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: colors.primary,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: order.status == 2
                                                  ? colors.success.withOpacity(
                                                      0.2,
                                                    )
                                                  : colors.primary.withOpacity(
                                                      0.2,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),

                                            child: Text(
                                              order.status == 2
                                                  ? "Stitching Completed"
                                                  : "Job Allocated!",
                                              style: TextStyle(
                                                color: order.status == 2
                                                    ? colors.success
                                                    : colors.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),

                                      // Details
                                      _buildInfoRow(
                                        context,
                                        "Invoice ",
                                        order.invoiceNumber.toString(),
                                      ),
                                      _buildInfoRow(
                                        context,
                                        "Job Allocate Date",
                                        '${formattedAllowcateDate[2]}-${formattedAllowcateDate[1]}-${formattedAllowcateDate[0]}',
                                      ),
                                      _buildInfoRow(
                                        context,
                                        "Unit Delivery Date",
                                        '${formattedDeliveryDate[2]}-${formattedDeliveryDate[1]}-${formattedDeliveryDate[0]}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Get.put(NavigationMenu()),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
            child: Text(
              "$label: ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateBox({
    required IconData icon,
    required String label,
    required String value,
    required AppColors colors,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: colors.primary, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
