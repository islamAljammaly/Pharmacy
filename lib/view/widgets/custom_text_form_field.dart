import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;
  final TextEditingController mycontroller;

  final void Function(String?)? onSave;
  final String? Function(String?)? validator;

  const CustomTextFormField({super.key, 
    required this.text,
    required this.hint,
    required this.onSave,
    required this.validator, required this.mycontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        TextFormField(
          controller: mycontroller,
          onSaved: onSave,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: Colors.white,
          ),
        )
      ],
    );
  }
}