import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmacy/view/screen/auth/signup_view.dart';
import '../../service/fire_store.dart';
import '../../modle/user.dart';
import '../../service/service.dart';
import '../../view/screen/user_home_page.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late TextEditingController email;
  late TextEditingController password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FireStore fireStore = FireStore();
  MyServices myServices = Get.find();
  bool isLoading = false;
  bool isshowpassword = true;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  void googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return;
    }

    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    try {
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      String? userName = userCredential.user?.displayName;
      fireStore.addUser(
        UserModel(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: userName ?? 'Unknown',
        ),
      );

      Get.offAll(const UserHomePage());
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  login() async {
    if (loginformKey.currentState!.validate()) {
      isLoading = true;
      update();
      var response = await fireStore.signInWithEmailAndPassword(email.text, password.text);
      print("=============================== Controller $response");
      if (response['status'] == "success") {
        myServices.sharedPreferences.setString("id", response['userId']);
        myServices.sharedPreferences.setString("email", response['email']);
        myServices.sharedPreferences.setString("step", "1");
        isLoading = false;
        Get.offAll(const UserHomePage());
      } else if (response['status'] == "disconnection") {
        Get.defaultDialog(title: "لا يوجد انترنت", middleText: "لقد تعذر الاتصال بالانترنت");
      } else {
        Get.defaultDialog(title: "warning", middleText: "${response['status']}");
      }
      update();
    }
  }

  showPassword() {
    isshowpassword = !isshowpassword;
    update();
  }

  forgetPassword() async {
    loginformKey.currentState?.save();
    if (email.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        Get.snackbar('Reset Password', 'لقد قمنا بإرسال رابط على ايميلك حتى تتمكن من تغيير كلمة السر الخاصة بك');
      } catch (e) {
        Get.snackbar('Error', 'your email is invalid');
      }
    } else {
      Get.snackbar('Error', 'Please enter your email to reset password');
    }
  }

  goToSignUp() {
    Get.off(const SignUp());
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
