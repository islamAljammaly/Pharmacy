import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/widgets/build_medicine_form.dart';
import '../view/widgets/custom_button.dart';
import '../view/widgets/custom_drop_down_button.dart';

void showRequestDialog(
  BuildContext context,
  RxString numberRequests,
  List<String> listNumbers,
  List<RxString> selectedType,
  List<String> listType,
  List<TextEditingController> name,
  List<TextEditingController> quantity,
  TextEditingController address,
  TextEditingController number,
  TextEditingController personName,
  String email,
  List<String> types,
  void Function(
    List<String> medicineName,
    String address,
    List<String> quantity,
    String number,
    List<String> types,
    String email,
    String personName,
    RxString requestState,
  ) sendReq,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      GlobalKey<FormState> keyForm = GlobalKey<FormState>();
      return Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: keyForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'املأ جميع الحقول التالية',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => CustomDropdownButton(
                            numberRequests.value,
                            (value) {
                              numberRequests.value = value!;
                            },
                            listNumbers
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const Text(
                          'كم عدد الادوية او الاغراض التي تنوي طلبها ؟',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    BuildMedicineForm(
                      selectedType: selectedType,
                      listType: listType,
                      name: name,
                      quantity: quantity,
                      numberRequests: numberRequests,
                      address: address,
                      number: number,
                      personName: personName,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      color: const Color.fromARGB(255, 54, 74, 105),
                      onPressed: () {
                        List<String> names = [];
                        List<String> quant = [];
                        if (keyForm.currentState!.validate()) {
                          keyForm.currentState!.save();
                          for (int i = 0; i < int.parse(numberRequests.value); i++) {
                            names.add(name[i].text);
                            quant.add(quantity[i].text);
                            types.add(selectedType[i].value);
                          }
                          sendReq(
                            names,
                            address.text,
                            quant,
                            number.text,
                            types,
                            email,
                            personName.text,
                            'قيد الانتظار'.obs,
                          );
                          types = [];
                          name = [];
                          quantity = [];
                          Get.back();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'تم إضافة طلبك بنجاح , سيتم التواصل معك في غضون 10 دقائق لاستلام طلبك , يمكنك متابعة حالة الطلب أسفل الصفحة',
                              ),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        }
                      },
                      text: 'أرسل طلبك',
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
