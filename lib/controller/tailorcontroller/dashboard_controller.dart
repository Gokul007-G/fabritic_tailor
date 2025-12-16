import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/model/orders_model.dart';
import 'package:fabritic/services/services.dart';
import 'package:fabritic/services/tailor/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  //Services
  final services = Get.put(DashboardService());
  final storageController = Get.find<StorageController>();
  final Services checkServices = Get.put(Services());

  //variables
  var orderList = <Order>[].obs;
  var searchQuery = ''.obs;
  TextEditingController textEditingController = TextEditingController();

  //Filter the Orders
  List<Order> get filteredOrders {
    if (searchQuery.value.isEmpty) {
      return orderList;
    } else {
      final query = searchQuery.value.toLowerCase();
      return orderList.where((order) {
        return ((order.customerName?.toLowerCase().contains(query) ?? false) ||
            (order.jbNo?.toLowerCase().contains(query) ?? false) ||
            (order.invoiceNumber?.toLowerCase().contains(query) ?? false));
      }).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getOrdersCnt(
      storageController.name.value,
      storageController.branchId.value,
    );
  }

  //View the Invoice in Id
  Future<void> getOrdersCnt(String empName, String branchId) async {
    //Check server connection
    bool serverConnect = await checkServices.checkServer(Get.context!);

    if (serverConnect) {
      final data = await services.getOrderSrc(empName, branchId);
      orderList.value = data;
    }
  }
}
