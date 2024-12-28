import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/view/widgets/custom_text.dart';
import '../../functions/validate.dart';
import 'custom_drop_down_button.dart';
import 'custom_text_form_field.dart';

class BuildMedicineForm extends StatelessWidget {
  final List<RxString> selectedType;
  final List<String> listType;
  final List<TextEditingController> name;
  final List<TextEditingController> quantity;
  final RxString numberRequests;
  final TextEditingController address;
  final TextEditingController number;
  final TextEditingController personName;

  const BuildMedicineForm({
    super.key,
    required this.selectedType,
    required this.listType,
    required this.name,
    required this.quantity,
    required this.numberRequests,
    required this.address,
    required this.number,
    required this.personName,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    int requestCount = int.parse(numberRequests.value);
    while (name.length < requestCount) {
      name.add(TextEditingController());
      quantity.add(TextEditingController());
      selectedType.add(RxString('')); 
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextFormField(
            mycontroller: name[0],
            text: 'اسم الدواء',
            hint: 'panadol',
            onSave: (val) {
              name[0].text = val!;
            },
            validator: (value) {
              return validate(value!, 5, 50, "name");
            },
          ),
          SizedBox(height: screenHeight * 0.01),
          CustomText(
            text: 'في حال كان طلبك دواء قد تحتمل أن تحتاج الى شريط أو علبة , يرجى اختيار ذلك', 
            alignmentGeometry: Alignment.center,
            weight: FontWeight.bold,
            alignText: TextAlign.right,
          ),
          Obx(() => CustomDropdownButton(
            selectedType[0].value,
            (value) {
              if (value != null) {
                selectedType[0].value = value;
              }
            },
            listType.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
          SizedBox(height: screenHeight * 0.02),
          CustomTextFormField(
            mycontroller: quantity[0],
            text: 'الكمية',
            hint: '1',
            onSave: (value) {
              quantity[0].text = value!;
            },
            validator: (value) {
              return validate(value!, 1, 2, "num");
            },
          ),
          Obx(() {
            int numberRequest = int.parse(numberRequests.value);
            if (numberRequest > 1) {
              return Column(
                children: List.generate(numberRequest - 1, (index) {
                  return Column(
                    children: [
                      const Divider(thickness: 2,color: Colors.black),
                      const Text('بيانات الدواء او الغرض التالي'),
                      CustomTextFormField(
                        mycontroller: name[index + 1],
                        text: 'اسم الدواء',
                        hint: 'panadol',
                        onSave: (value) {
                          name[index + 1].text = value!;
                        },
                        validator: (value) {
                          return validate(value!, 5, 50, "name");
                        }
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text('في حال كان طلبك دواء قد تحتمل أن تحتاج الى شريط أو علبة , يرجى اختيار ذلك', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
                      Obx(() => CustomDropdownButton(
                        selectedType[index + 1].value,
                        (value) {
                          if (value != null) {
                            selectedType[index + 1].value = value;
                          }
                        },
                        listType.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextFormField(
                        mycontroller: quantity[index + 1],
                        text: 'الكمية',
                        hint: '1',
                        onSave: (value) {
                          quantity[index + 1].text = value!;
                        },
                        validator: (value) {
                          return validate(value!, 1, 2, "num");
                        }
                      ),
                    ],
                  );
                }),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          CustomTextFormField(
            mycontroller: address,
            text: 'العنوان بالتفصيل',
            hint: 'حي النصر - عمارة الدولي 3 - مقابل مسجد الشهيدين',
            onSave: (value) {
              address.text = value!;
            },
            validator: (value) {
             return validate(value!, 10, 100, "address");
            },
          ),
          CustomTextFormField(
            mycontroller: number,
            text: 'الرقم للتواصل عند التسليم',
            hint: '0598347668',
            onSave: (value) {
              number.text = value!;
            },
            validator: (value) {
              return validate(value!, 7, 12, "phone");
            },
          ),
          CustomTextFormField(
            mycontroller: personName,
            text: 'الطلبية باسم من ؟',
            hint: 'يرجى كتابة الاسم الاول واسم العائلة',
            onSave: (value) {
              personName.text = value!;
            },
            validator: (value) {
              return validate(value!, 5, 50, "fullName");
            },
          ),
        ],
      ),
    );
  }
}
