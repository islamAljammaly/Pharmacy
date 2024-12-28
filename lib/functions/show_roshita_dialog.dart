import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/functions/validate.dart';

import '../view/widgets/custom_button.dart';
import '../view/widgets/custom_text_form_field.dart';

void showRoshitaDialog(BuildContext context, TextEditingController address, TextEditingController number, TextEditingController personName, void Function()? onPress, Rx<File?> file, String email, void Function(File image,
  String address,
  String number,
  String email,
  String personName,
  RxString requestState,) sendRosh) {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: keyForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('املأ جميع الحقول التالية', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    CustomButton(
                      color: const Color.fromARGB(255, 54, 74, 105),
                      onPressed: () {
                        onPress!();
                      },
                      text: 'ضع صورة الروشيتة',
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return file.value != null
                          ? SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.file(file.value!),
                            )
                          : const SizedBox();
                    }),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      text: 'العنوان بالتفصيل',
                      hint: 'حي النصر - عمارة الدولي 3 - مقابل مسجد الشهيدين',
                      onSave: (value) {
                        address.text = value!;
                      },
                      validator: (value) {
                        validate(value!, 10, 100, 'address');
                      },
                      mycontroller: address,
                    ),
                    CustomTextFormField(
                      text: 'الرقم للتواصل عند التسليم',
                      hint: '0598347668',
                      onSave: (value) {
                        number.text = value!;
                      },
                      validator: (value) {
                        validate(value!, 7, 12, 'phone');
                      },
                      mycontroller: number,
                    ),
                    CustomTextFormField(
                      text: 'الطلبية باسم من ؟',
                      hint: 'يرجى كتابة الاسم الاول واسم العائلة',
                      onSave: (value) {
                        personName.text = value!;
                      },
                      validator: (value) {
                        validate(value!, 10, 50, 'fullName');
                      },
                      mycontroller: personName,
                    ),
                    CustomButton(
                      color: const Color.fromARGB(255, 54, 74, 105),
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          keyForm.currentState!.save();
                          if (file.value != null) {
                            sendRosh(file.value!, address.text, number.text, email, personName.text, 'قيد الانتظار'.obs);
                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم إرسال الروشيتة الخاصة بك , سيتم التواصل معك خلال 10 دقائق لتسليمك الطلب , يمكنك متابعة حالة طلبك أسفل الصفحة'),
                                duration: Duration(seconds: 5),
                              ),
                            );
                          } else {
                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('لم يتم إضافة الروشيتة , يرجى إضافة صورة الروشيتة'),
                                duration: Duration(seconds: 5),
                              ),
                            );
                          }
                        }
                      },
                      text: 'أرسل الروشيتة للطلب',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
