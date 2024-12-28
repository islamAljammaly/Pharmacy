import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacy/service/service.dart';
import 'package:pharmacy/view/screen/start_page_view.dart';
import 'binding/bindings.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
   Get.put(MyServices()); 
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown 
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: StartPageView(),
    );
  }
}
