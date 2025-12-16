import 'package:fabritic/controller/login_controller.dart';
import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/services/login_services.dart';
import 'package:fabritic/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class BiometricController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final storageController = Get.find<StorageController>();
  final loginServices = Get.find<LoginServices>();
  final loginController = Get.find<LoginController>();

  var isAuthenticated = false.obs;
  var message = ''.obs;

  Future<void> authenticate(BuildContext context) async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      bool supported = await auth.isDeviceSupported();

      if (!canCheck || !supported) {
        message.value = 'Biometric not available';
        Get.to(() => LoginPage());
        return;
      }

      bool result = await auth.authenticate(
        localizedReason: 'Scan your fingerprint or face to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (result) {
        loginController.submit(context);
        isAuthenticated.value = true;
      } else {
        message.value = 'failed';
      }
    } catch (e) {
      message.value = 'Error';
    }
  }
}
