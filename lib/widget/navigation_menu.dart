import 'package:fabritic/controller/navigation/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});
  final NavigationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (value) {
          controller.selectedIndex.value = value;
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shop), label: 'Store'),
          NavigationDestination(
            icon: Icon(Icons.heat_pump_rounded),
            label: 'List',
          ),
          NavigationDestination(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
