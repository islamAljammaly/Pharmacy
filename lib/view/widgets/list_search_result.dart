import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/view/widgets/custom_gesturedetector.dart';

import '../../modle/medicine.dart';

class ListSearchResult extends StatelessWidget{
  final int itemsCount;
  final RxList<Medicine> filterMedicines;
  final String email;
  final void Function(String) onPressedDeleteButton;

  const ListSearchResult({super.key, required this.itemsCount, required this.filterMedicines, required this.email,required this.onPressedDeleteButton});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemsCount,
                    itemBuilder: (context, index) {
                      Medicine medicine = filterMedicines[index];
                      return CustomGestureDetector(medicine: medicine);
                    },
                  );
  }
}