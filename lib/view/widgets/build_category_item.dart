import 'package:flutter/material.dart';

class BuildCategoryItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String image;
  const BuildCategoryItem({super.key, required this.title,required this.onTap, required this.image});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white54,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: screenWidth * 0.5, 
      width: screenWidth * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.asset(image, fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }

}