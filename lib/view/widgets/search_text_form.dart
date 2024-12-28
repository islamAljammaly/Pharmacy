import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/controller/user_controller.dart';

class SearchTextForm extends StatelessWidget {
  const SearchTextForm({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return TextField(
                  onChanged: (value) {
                    userController.searchText.value = value;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                    userController.filterMedicines(value);
                    if (value.isNotEmpty && userController.allMedicines.isEmpty) {
                    userController.fetchMedicines();
        }
    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search for medicine',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                );
  }

}