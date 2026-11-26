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

  final showDateSelcter = true.obs;
  late Rx<DateTime> fromDate;
  late Rx<DateTime> toDate;

  //variables
  final isLoading = false.obs;
  var orderList = <Order>[].obs;
  var searchQuery = ''.obs;
  TextEditingController textEditingController = TextEditingController();

  final name = ''.obs;
  final branchId = ''.obs;

  final pickedDateError = false.obs;

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

    name.value = storageController.name.value;
    branchId.value = storageController.branchId.value;
    selectCurrentMonth();
  }

  void selectCurrentMonth() {
    final now = DateTime.now();

    fromDate = DateTime(now.year, now.month, 1).obs;
    toDate = DateTime(now.year, now.month + 1, 0).obs;
    showDateSelcter.value = !showDateSelcter.value;
    getOrdersCnt();
  }

  Future<void> pickDate(BuildContext context, Rx<DateTime> selectedDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
    if (fromDate.value.isAfter(toDate.value)) {
      pickedDateError.value = true;
    } else {
      pickedDateError.value = false;
    }
  }

  //View the Invoice in Id
  Future<void> getOrdersCnt() async {
    //Check server connection
    bool serverConnect = await checkServices.checkServer(Get.context!);
    isLoading.value = true;

    if (serverConnect) {
      final data = await services.getOrderSrc(
        name.value,
        branchId.value,
        fromDate.value,
        toDate.value,
      );
      orderList.value = data;
    }
    isLoading.value = false;
  }
}
