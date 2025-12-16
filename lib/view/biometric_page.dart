import 'package:fabritic/controller/biometric/biometric_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BiometricPage extends StatelessWidget {
  BiometricPage({super.key});

  final BiometricController controller = Get.put(BiometricController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => controller.authenticate(context));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint, size: 80, color: Colors.blue),
              const SizedBox(height: 30),
              Text(
                controller.message.value.isEmpty
                    ? "Authenticating..."
                    : controller.message.value,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.offNamed('/LoginPage'),
                child: const Text("Login with Mobile Number"),
              ),
            ],
          );
        }),
      ),
    );
  }
}
