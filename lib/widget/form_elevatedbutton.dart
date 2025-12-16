import 'package:fabritic/controller/login_controller.dart';
import 'package:fabritic/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormElevatedbutton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onpressed;

  final controller = Get.find<LoginController>();

  FormElevatedbutton({
    super.key,
    required this.label,
    this.icon,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,

      child: ElevatedButton(
        onPressed: onpressed,
        // onPressed: controller.isLoading.value ? null : onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.isLoading.value) ...[
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(width: 8),
            ],
            if (icon != null && !controller.isLoading.value)
              Icon(icon, color: colors.background, size: 16),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(color: colors.background, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
