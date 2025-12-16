import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/model/user_model.dart';
import 'package:fabritic/services/login_services.dart';
import 'package:fabritic/services/services.dart';
import 'package:fabritic/view/tailor/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginMethod { password, otp }

class LoginController extends GetxController {
  // Services
  final LoginServices services = Get.put(LoginServices());
  final Services checkServices = Get.put(Services());
  final StorageController storageController = Get.find<StorageController>();

  // Form key
  final loginformkey = GlobalKey<FormState>();

  // Variables
  var user = Rxn<User>();
  var selectedMethod = LoginMethod.password.obs;
  var visibilityText = true.obs;
  var isLoading = false.obs;
  bool biometricChecked = false;

  // Text Controllers
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  // Toggle password visibility
  void togglePasswordVisibility() {
    visibilityText.value = !visibilityText.value;
  }

  // Change login method
  void changeMethod(LoginMethod method) {
    selectedMethod.value = method;
  }

  // Submit login
  Future<void> submit(BuildContext context) async {
    //check the server and network connection
    if (isLoading.value) return;
    isLoading.value = true;
    bool serverConnect = await checkServices.checkServer(context);
    if (serverConnect) {
      final result = await services.login(
        mobileNoController.text,
        passwordController.text,
      );

      user.value = result;
      if (user.value != null) {
        Get.snackbar(
          '🎉 Welcome!',
          '${user.value!.name}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          borderRadius: 15,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          icon: const Icon(Icons.check_circle, color: Colors.white, size: 30),
          shouldIconPulse: true,
          duration: const Duration(seconds: 3),
          overlayBlur: 0,
          boxShadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          reverseAnimationCurve: Curves.easeInCubic,
        );

        await storageController.saveUser(
          user.value!.id.toString(),
          user.value!.branchId.toString(),
          user.value!.name.toString(),
          user.value!.empCode.toString(),
          user.value!.mobileNumber.toString(),
          passwordController.text.toString(),
          user.value!.userRole.toString(),
        );
        isLoading.value = false;

        Get.to(() => DashBoardScreen());
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    mobileNoController.dispose();
    passwordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
