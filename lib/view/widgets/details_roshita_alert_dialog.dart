import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modle/roshita.dart';

class DetailsRoshitaAlertDialog extends StatelessWidget {
  final Roshita roshita;
  const DetailsRoshitaAlertDialog({super.key, required this.roshita});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
                  title: const Text('تفاصيل الطلب', textAlign: TextAlign.center),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${roshita.personName} : اسم المشتري'),
                        const SizedBox(height: 10),
                        Text('${roshita.address} : العنوان'),
                        const SizedBox(height: 10),
                        Text('${roshita.email} : الايميل'),
                        const SizedBox(height: 10),
                        Text('${roshita.number} : رقم الهاتف'),
                        const SizedBox(height: 10),
                                SizedBox(
                                height: screenHeight * 0.25,
                                width: screenWidth * 0.5,
                                child: Image.network(
                                  roshita.image!,
                                ),   
                                 )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('إغلاق'),
                    ),
                  ],
                );
  }

}