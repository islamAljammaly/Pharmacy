import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/view/control.dart';

class StartPageController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Get.off(ControlView());
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
