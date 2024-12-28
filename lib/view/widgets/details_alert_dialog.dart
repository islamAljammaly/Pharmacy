import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modle/request.dart';

class DetailsRequestAlertDialog extends StatelessWidget {
  final Request request;
  const DetailsRequestAlertDialog({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                  title: const Text('تفاصيل الطلب', textAlign: TextAlign.center),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('اسم المشتري : ${request.personName}'),
                      const SizedBox(height: 10),
                      Text('العنوان : ${request.address}'),
                      const SizedBox(height: 10),
                      const Text(': الايميل'),
                      Text(request.email!),
                      const SizedBox(height: 10),
                      Text('${request.number} : رقم الهاتف'),
                      const SizedBox(height: 10),
                      const Text(': اسم الدواء'),
                      Text(request.medicineName!.join(', ')),
                      const SizedBox(height: 10),
                      Text('${request.quantity!.join(', ')} : الكمية'),
                      const SizedBox(height: 10),
                      const Text(': نوع الطلب'),
                      Text(request.type!.join(', ')),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close the dialog
                      },
                      child: const Text('إغلاق'),
                    ),
                  ],
                );
  }

}