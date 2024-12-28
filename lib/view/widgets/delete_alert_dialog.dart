import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/controller/user_controller.dart';

class DeleteAlertDialog extends StatelessWidget {
  final String id;
  final String type;

  const DeleteAlertDialog({
    super.key, required this.id, required this.type,
  });

  @override
  Widget build(BuildContext context) {
    UserController controller = Get.put(UserController());
    return AlertDialog(
      title: const Text('تأكيد الحذف'),
      content: const Text('هل تريد حذف هذا الطلب؟'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: () {
            print('Deleting request with ID: $id');
            type == 'req' ? controller.deleteRequest(id)
            : controller.deleteRoshita(id);
            Get.back(); // Close the dialog after deletion
          },
          child: const Text('تأكيد'),
        ),
      ],
    );
  }
}
