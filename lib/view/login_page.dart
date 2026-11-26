import 'package:fabritic/controller/biometric/biometric_controller.dart';
import 'package:fabritic/controller/login_controller.dart';
import 'package:fabritic/controller/storage/storage_controller.dart';
import 'package:fabritic/theme/app_colors.dart';
import 'package:fabritic/widget/form_elevatedbutton.dart';
import 'package:fabritic/widget/form_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.put(LoginController());

  final biometricController = Get.put(BiometricController());

  final storageController = Get.find<StorageController>();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors(context);
    // if (storageController.number.value.isNotEmpty) {
    //   controller.mobileNoController.text = storageController.number.value;
    //   controller.passwordController.text = storageController.password.value;
    // }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.loginformkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!biometricController.isAuthenticated.value)
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Image.asset(
                      'assets/icons/tailorlog.gif',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 20),

                //Use the Customer Login
                // Obx(
                //   () => Row(
                //     children: [

                //       Row(
                //         children: [
                //           Radio<LoginMethod>(
                //             groupValue: controller.selectedMethod.value,
                //             activeColor: colors.primary,
                //             value: LoginMethod.password,
                //             onChanged: (value) =>
                //                 controller.changeMethod(value!),
                //           ),
                //           Text('Password'),
                //         ],
                //       ),
                //       const SizedBox(width: 20),
                //       Row(
                //         children: [
                //           Radio(
                //             // title: const Text("OTP"),
                //             groupValue: controller.selectedMethod.value,
                //             activeColor: colors.primary,
                //             value: LoginMethod.otp,
                //             onChanged: (value) =>
                //                 controller.changeMethod(value!),
                //           ),
                //           Text('OTP'),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                FormTextfiled(
                  controller: controller.mobileNoController,
                  prefixIcon: Icons.person,
                  labelText: "Mobile Number",
                  hintText: "Enter Mobile Number",
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Mobile Number";
                    }
                    if (value.length == 9) {
                      return "Please enter the 10 number";
                    }
                    return null;
                  },
                ),

                //show password or otp filed
                Obx(
                  () => controller.selectedMethod.value == LoginMethod.password
                      ? Column(
                          children: [
                            FormTextfiled(
                              controller: controller.passwordController,
                              prefixIcon: controller.visibilityText.value
                                  ? Icons.lock
                                  : Icons.lock_open,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.visibilityText.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: colors.primary,
                                ),

                                onPressed: controller.togglePasswordVisibility,
                              ),
                              obscureText: controller.visibilityText.value,
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            FormTextfiled(
                              controller: controller.otpController,
                              prefixIcon: Icons.output,
                              inputType: TextInputType.number,
                              labelText: 'OTP',
                              hintText: 'Enter OTP Number',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter OTP";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                ),

                Obx(
                  () => controller.selectedMethod.value == LoginMethod.password
                      ? FormElevatedbutton(
                          label: controller.isLoading.value
                              ? 'Logging in...'
                              : 'Submit',
                          icon: Icons.outgoing_mail,
                          onpressed: () {
                            if (controller.loginformkey.currentState!
                                .validate()) {
                              controller.submit(context);
                            }
                          },
                        )
                      : FormElevatedbutton(
                          label: 'Generate OTP',
                          icon: Icons.outbox_sharp,
                          onpressed: () {
                            if (controller.loginformkey.currentState!
                                .validate()) {
                              controller.submit(context);
                            }
                          },
                        ),
                ),
                const SizedBox(height: 15),
                if (storageController.name.value.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      biometricController.authenticate(context);
                    },
                    icon: Icon(
                      Icons.fingerprint,
                      color: colors.primary,
                      size: 60,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              // 'assets/icons/BBLogo.jpeg',
              'assets/icons/bluebase_logo.png',
              height: 70,
              width: 100,
              fit: BoxFit.cover,
            ),
            // Text("Bluebase Software Solutions Pvt Ltd"),
            Text(
              'V1.0_14/10/2025_D',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
