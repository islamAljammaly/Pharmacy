import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/view/screen/auth/login_view.dart';
import '../../service/fire_store.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> signformKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController name;
  FireStore fireStore = FireStore();

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  signUp() async {
    if (signformKey.currentState!.validate()) {
      var response = await fireStore.signUpPostData({
        "name": name.text,
        "password": password.text,
        "email": email.text,
      });
      print("=============================== Controller $response");
      if (response['status'] == "verification_email_sent") {
        Get.snackbar('Email verification', 'يرجى التوجه الى ايميلك والضغط على الرابط الذي قمنا بإرساله للتحقق حتى تتمكن من الدخول الى حسابك');
        Future.delayed(const Duration(seconds: 6), () {
          Get.offAll(const LoginScreen());
        });
      } else if (response['status'] == "disconnection") {
        Get.defaultDialog(title: "لا يوجد انترنت", middleText: "لقد تعذر الاتصال بالانترنت");
      } else {
        Get.defaultDialog(title: "warning", middleText: "${response['status']}");
      }
    }
  }

  goToSignIn() {
    Get.off(const LoginScreen());
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
