import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/controller/painkillers_controller.dart';
import 'package:pharmacy/view/widgets/custom_gesturedetector.dart';
import 'package:pharmacy/view/widgets/custom_text.dart';
import '../../modle/medicine.dart';

class Painkillers extends StatelessWidget {
  final PainkillersController painController = Get.put(PainkillersController());

  Painkillers({super.key});

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 74, 105),
        title: CustomText(text: 'المسكنات'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (painController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (painController.medicines.isEmpty) {
          return const Center(child: Text('لا يوجد مسكنات'));
        } else {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.035),
            child: ListView.separated(
              itemCount: painController.medicines.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Medicine medicine = painController.medicines[index];
                return CustomGestureDetector(medicine: medicine);
              },
              separatorBuilder: (context, index) => const Divider(color: Colors.black,),
            ),
          );
        }
      }),
    );
  }
}
