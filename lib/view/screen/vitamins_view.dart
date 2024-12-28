import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/controller/vitamins_controller.dart';
import 'package:pharmacy/view/widgets/custom_gesturedetector.dart';
import 'package:pharmacy/view/widgets/custom_text.dart';
import '../../modle/medicine.dart';

class Vitamins extends StatelessWidget {
  final VitaminsController vitaController = Get.put(VitaminsController());

  Vitamins({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 74, 105),
        centerTitle: true,
        title: CustomText(text: 'الفيتامينات')
      ),
      body: Obx(() {
        if (vitaController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } 
        else if (vitaController.medicines.isEmpty) {
          return const Center(child: Text('لا يوجد فيتامينات'));
        } else {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.035),
            child: ListView.separated(
              itemCount: vitaController.medicines.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Medicine medicine = vitaController.medicines[index];
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
