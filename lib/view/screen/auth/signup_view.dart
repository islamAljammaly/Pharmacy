import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/view/widgets/custom_text_form_auth.dart';

import '../../../controller/auth/signup_controller.dart';
import '../../../functions/validate.dart';
import '../../widgets/custom_button.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            controller.goToSignIn();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'قم بالتسجيل الان حتى تستفيد من خدمات التطبيق',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ScheherazadeNew',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover,
                      opacity: 500,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.08,
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Form(
                      key: controller.signformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormAuth(
                            hinttext: "mohammed",
                            labeltext: "name",
                            iconData: Icons.person_2_outlined,
                            mycontroller: controller.name,
                            valid: (val) {
                              return validate(val!, 3, 20, "name");
                            },
                            isNumber: false,
                          ),
                          CustomTextFormAuth(
                            hinttext: "iammohammed@gmail.com",
                            labeltext: "email",
                            iconData: Icons.email_outlined,
                            mycontroller: controller.email,
                            valid: (val) {
                              return validate(val!, 3, 40, "email");
                            },
                            isNumber: false,
                          ),
                          CustomTextFormAuth(
                            hinttext: "********",
                            labeltext: "password",
                            iconData: Icons.lock_outline,
                            mycontroller: controller.password,
                            valid: (val) {
                              return validate(val!, 3, 30, "password");
                            },
                            isNumber: false,
                          ),
                          Center(
                            child: CustomButton(
                              color: const Color.fromARGB(255, 3, 28, 66),
                              text: 'SIGN UP',
                              onPressed: () {
                                controller.signUp();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
