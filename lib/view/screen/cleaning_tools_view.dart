import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/controller/cleaning_tools_controller.dart';
import 'package:pharmacy/view/widgets/custom_gesturedetector.dart';
import 'package:pharmacy/view/widgets/custom_text.dart';
import '../../modle/medicine.dart';

class CleaningTools extends StatelessWidget {
  final CleaningToolsController cleanController = Get.put(CleaningToolsController());

  CleaningTools({super.key});

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 74, 105),
        centerTitle: true,
        title: CustomText(text: 'أدوات النظافة الشخصية والكسور والجروح')
      ),
      body: Obx(() {
        if (cleanController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } 
        else if (cleanController.medicines.isEmpty) {
          return const Center(child: Text('لا يوجد'));
        } else {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.035),
            child: ListView.separated(
              itemCount: cleanController.medicines.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Medicine medicine = cleanController.medicines[index];
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
