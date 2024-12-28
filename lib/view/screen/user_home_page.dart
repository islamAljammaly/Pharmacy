import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/functions/show_request_dialog.dart';
import 'package:pharmacy/functions/show_roshita_dialog.dart';
import 'package:pharmacy/view/widgets/build_categories.dart';
import 'package:pharmacy/view/widgets/custom_text.dart';
import 'package:pharmacy/view/widgets/list_requests.dart';
import 'package:pharmacy/view/widgets/list_roshita.dart';
import 'package:pharmacy/view/widgets/list_search_result.dart';
import 'package:pharmacy/view/widgets/logout_icon.dart';
import 'package:pharmacy/view/widgets/request_button.dart';
import 'package:pharmacy/view/widgets/search_text_form.dart';
import '../../controller/user_controller.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          LogOutIcon(onPress: (){userController.logOut();})
        ],
        backgroundColor: const Color.fromARGB(255, 54, 74, 105),
        title: CustomText(text: 'صيدلية الاسعاف'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.cover,
            opacity: 500
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchTextForm(),
                SizedBox(height: screenHeight* 0.01),
                RequestButton(
                  text: "أرسل طلبك",
                  onPressed: (){
                    showRequestDialog(
                      context,
                      userController.numberRequests,
                      userController.listNumbers,
                      userController.selectedType,
                      userController.listType,
                      userController.name,
                      userController.quantity,
                      userController.address,
                      userController.number,
                      userController.personName,
                      userController.email,
                      userController.types,
                      (
                        List<String> medicineName,
                        String address,
                        List<String> quantity,
                        String number,
                        List<String> types,
                        String email,
                        String personName,
                        RxString requestState,
                      ) {
                        userController.sendRequest(medicineName, address, quantity, number, types, email, personName, requestState);
                      }
                    );
                  },
                  color: const Color.fromARGB(255, 54, 74, 105),
                  icon: Icons.medication_outlined,
                  containerWidth: 150,
                ),
                RequestButton(
                  text: 'أرسل طلب عن طريق الروشتة الخاصة بك',
                  onPressed: (){
                    showRoshitaDialog(
                      context,
                      userController.address,
                      userController.number,
                      userController.personName,
                      () async{await userController.getImage();},
                      userController.file,
                      userController.email,
                      (
                        File image,
                        String address,
                        String number,
                        String email,
                        String personName,
                        RxString requestState,
                      ) {
                        userController.sendRoshita(image, address, number, email, personName, requestState);
                      }
                    );
                  },
                  color: const Color.fromARGB(255, 54, 74, 105),
                  icon: Icons.image,
                  containerWidth: 280,
                ),
                SizedBox(height: screenHeight * 0.02),
                Obx(() {
                  if (userController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (userController.filteredMedicines.isEmpty) {
                    if (userController.searchText.value.isNotEmpty) {
                      return Center(
                        child: Text(
                          'No medicines found for "${userController.searchText.value}".',
                        ),
                      );
                    } else {
                      return const BuildDefaultCategories();
                    }
                  }
                  return ListSearchResult(
                    itemsCount: userController.filteredMedicines.length,
                    filterMedicines: userController.filteredMedicines,
                    email: userController.email,
                    onPressedDeleteButton: (String id) {
                      userController.deleteMedicine(id);
                    },
                  );
                }),
                SizedBox(height: screenHeight * 0.01),
                CustomText(text: 'قائمة الطلبات الخاصة بك ', alignmentGeometry: Alignment.centerRight),
                Obx(() {
                  final sortedRequests = userController.requests
                    ..sort((a, b) => a.addedTime!.compareTo(b.addedTime!));
                  return ListRequests(sortedRequests: sortedRequests);
                }),
                const Divider(thickness: 2, color: Colors.black),
                Obx(() {
                  final sortedRoshita = userController.roshita
                    ..sort((a, b) => a.addedTime!.compareTo(b.addedTime!));
                  return ListRoshita(sortedRequests: sortedRoshita);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
