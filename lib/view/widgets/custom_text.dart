import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  AlignmentGeometry? alignmentGeometry;
  FontWeight? weight = FontWeight.normal;
  double? size = 14;
  Color? color = Colors.black;
  TextAlign? alignText = TextAlign.center;
  CustomText({super.key, required this.text, this.alignmentGeometry, this.weight,this.size,this.color,this.alignText});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignmentGeometry == null ? Alignment.center : alignmentGeometry!,
      child: Text(text,style: TextStyle(fontFamily: 'ScheherazadeNew',fontWeight: weight,fontSize: size,color: color),textAlign: alignText),
    );
  }

}