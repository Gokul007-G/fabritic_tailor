import 'package:fabritic/bindings/app_bindings.dart';
import 'package:fabritic/controller/biometric/biometric_controller.dart';
import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/services/login_services.dart';
import 'package:fabritic/theme/app_theme.dart';
import 'package:fabritic/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize CustomerController
  final storageController = Get.put(StorageController());

  // Load stored user data
  final userData = await storageController.loadUser();
  storageController.tableId.value = userData['tableId'] ?? '';
  storageController.branchId.value = userData['branchId'] ?? '';
  storageController.name.value = userData['name'] ?? '';
  storageController.empCode.value = userData['empCode'] ?? '';
  storageController.number.value = userData['number'] ?? '';
  storageController.password.value = userData['password'] ?? '';
  storageController.role.value = userData['role'] ?? '';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      home: LoginPage(),
    );
  }
}
