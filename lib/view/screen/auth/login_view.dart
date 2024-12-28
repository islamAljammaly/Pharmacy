import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/controller/auth/login_controller.dart';
import 'package:pharmacy/view/widgets/custom_text.dart';
import 'package:pharmacy/view/widgets/custom_text_form_auth.dart';
import 'package:pharmacy/view/widgets/google_sign_button.dart';
import '../../../functions/validate.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
        builder: (controller) =>
            controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            alignment: Alignment.center,
                            height: 120,
                            width: 180,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/pic4.jpg'),
                                    fit: BoxFit.fill)),
                            child: const SizedBox(),
                          ),
                        ),
                        CustomText(
                          text: 'مرحباً بكم في صيدلية الإسعاف',
                          alignmentGeometry: Alignment.center,
                          color: const Color.fromARGB(255, 58, 111, 1),
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/logo.png'),
                                fit: BoxFit.cover,
                                opacity: 500,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.03,
                                right: screenWidth * 0.05,
                                left: screenWidth * 0.05,
                              ),
                              child: Form(
                                key: controller.loginformKey,
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: 'أدخل الايميل وكلمة السر لتسجيل الدخول',
                                      alignmentGeometry: Alignment.center,
                                      color: const Color.fromARGB(255, 3, 28, 66),
                                      size: 20,
                                      weight: FontWeight.bold,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.goToSignUp();
                                          },
                                          child: CustomText(
                                            text: 'سجل من هنا؟',
                                            alignmentGeometry: Alignment.center,
                                            color: const Color.fromARGB(255, 58, 111, 1),
                                            size: 20,
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        CustomText(
                                          text: 'اذا لم يكن لديك حساب',
                                          alignmentGeometry: Alignment.center,
                                          color: const Color.fromARGB(255, 3, 28, 66),
                                          size: 20,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    CustomTextFormAuth(
                                      isNumber: false,
                                      valid: (val) {
                                        return validate(val!, 5, 100, "email");
                                      },
                                      mycontroller: controller.email,
                                      hinttext: "iammohammed@gmail.com",
                                      iconData: Icons.email_outlined,
                                      labeltext: "Email",
                                    ),
                                    GetBuilder<LoginController>(
                                      builder: (controller) =>
                                          CustomTextFormAuth(
                                        obscureText: controller.isshowpassword,
                                        onTapIcon: () {
                                          controller.showPassword();
                                        },
                                        isNumber: false,
                                        valid: (val) {
                                          return validate(val!, 3, 30, "password");
                                        },
                                        mycontroller: controller.password,
                                        hinttext: "*********",
                                        iconData: Icons.lock_outline,
                                        labeltext: "Password",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        controller.forgetPassword();
                                      },
                                      child: CustomText(
                                          text: 'هل نسيت كلمة السر؟',
                                          alignmentGeometry: Alignment.centerRight),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    CustomButton(
                                      color: const Color.fromARGB(255, 3, 28, 66),
                                      onPressed: () {
                                        controller.login();
                                      },
                                      text: 'SIGN IN',
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    GoogleSignInButton(onPress: () {
                                      controller.googleSignInMethod();
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
