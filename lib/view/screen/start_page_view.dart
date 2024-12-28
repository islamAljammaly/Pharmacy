import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/start_page_controller.dart';

class StartPageView extends StatelessWidget {
  final StartPageController controller = Get.put(StartPageController());

  StartPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: GetBuilder<StartPageController>(
          builder: (_) {
            return AnimatedBuilder(
              animation: controller.animation,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.rotationY(controller.animation.value * 3.14 * 2),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: controller.animation.value,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.9, 
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
