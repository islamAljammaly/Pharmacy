import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/antibiotics_view.dart';
import '../screen/cleaning_tools_view.dart';
import '../screen/painkillers_view.dart';
import '../screen/vitamins_view.dart';
import 'build_category_item.dart';

class BuildDefaultCategories extends StatelessWidget {
  const BuildDefaultCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildCategoryItem(title: 'المسكنات', onTap: () => Get.to(Painkillers()), image: 'assets/pain.png'),
            BuildCategoryItem(title: 'المضادات الحيوية', onTap:() => Get.to(Antibiotics()), image: 'assets/anti.png'),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildCategoryItem(title: 'الفيتامينات', onTap: () => Get.to(Vitamins()), image: 'assets/vita.png'),
            BuildCategoryItem(title: 'النظافة الشخصية', onTap: () => Get.to(CleaningTools()), image: 'assets/clean.png'),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}