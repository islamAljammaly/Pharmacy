import 'package:flutter/material.dart';

import '../../modle/medicine.dart';
import 'build_medicine_item.dart';

class CustomGestureDetector extends StatelessWidget {
  final Medicine medicine;
  const CustomGestureDetector({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                        onTap: () {
                          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('تفاصيل الدواء', textAlign: TextAlign.center),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${medicine.name} : اسم الدواء'),
                        const SizedBox(height: 10),
                        Text('${medicine.price} : سعر الدواء'),
                        const SizedBox(height: 10),
                        const Text(' : تفاصيل الدواء'),
                        medicine.details == null ?
                        const Text('لا يوجد تفاصيل حاليا لهذا الدواء') :
                        Text('${medicine.details}',textAlign: TextAlign.right),
                      ]
                    ),
                  ),
                );
              },
                          );
                        },
                        child: BuildMedicineItem(context: context, medicine: medicine)
                      );
  }

}