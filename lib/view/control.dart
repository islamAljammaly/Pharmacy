import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/view/screen/user_home_page.dart';
import 'package:pharmacy/view/screen/auth/login_view.dart';
import '../service/service.dart';

class ControlView extends StatelessWidget {
  final MyServices myServices = Get.find<MyServices>();

  ControlView({super.key});

  @override
  Widget build(BuildContext context) {
      final step = myServices.sharedPreferences.getString("step") ?? "0";
      if (step == "1") {
        return const UserHomePage();
      }
      return const LoginScreen();
  }
}
