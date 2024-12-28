import 'package:flutter/material.dart';

class RequestButton extends StatelessWidget {
  final String text;
 final void Function()? onPressed;
 final Color color;
 final IconData icon;
 final double containerWidth;

  const RequestButton({Key? key, required this.text,required this.onPressed,required this.color, required this.icon, required this.containerWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: containerWidth,
        margin:const EdgeInsets.only(top: 10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding:const EdgeInsets.symmetric(vertical: 13),
          onPressed: onPressed,
          color: color,
          textColor: Colors.white,
          child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(icon),
                        const SizedBox(width: 3,),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(text),
                        ),
                      ],
                    ),
          ),
        ),
    );
  }

}