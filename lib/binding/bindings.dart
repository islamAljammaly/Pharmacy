import 'package:get/get.dart';
import 'package:pharmacy/controller/auth/login_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}