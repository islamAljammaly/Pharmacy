import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
 final String text;
 final void Function()? onPressed;
 final Color color;
  const CustomButton({Key? key, required this.text,required this.onPressed,required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin:const EdgeInsets.only(top: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding:const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPressed,
        color: color,
        textColor: Colors.white,
        child: Text(text , style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 16)),
      ),
    );
  }
}