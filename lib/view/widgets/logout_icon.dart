import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutIcon extends StatelessWidget {
  final void Function()? onPress;
  const LogOutIcon({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('تأكيد تسجيل الخروج'),
              content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    if (onPress != null) {
                      onPress!();
                    }
                    Get.back();
                  },
                  child: const Text('تسجيل الخروج'),
                ),
              ],
            );
          },
        );}, icon: const Icon(Icons.logout));
  }
}