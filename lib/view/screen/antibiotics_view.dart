import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/view/widgets/custom_gesturedetector.dart';
import 'package:pharmacy/view/widgets/custom_text.dart';
import '../../controller/antibiotics_controller.dart';
import '../../modle/medicine.dart';

class Antibiotics extends StatelessWidget {
  final AntibioticsController antiController = Get.put(AntibioticsController());

   Antibiotics({super.key});

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 74, 105),
        centerTitle: true,
        title: CustomText(text: 'المضادات الحيوية')
      ),
      body: Obx(() {
        if (antiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (antiController.medicines.isEmpty) {
          return const Center(child: Text('لا يوجد مضادات حيوية'));
        } else {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.035),
            child: ListView.separated(
              itemCount: antiController.medicines.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Medicine medicine = antiController.medicines[index];
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
