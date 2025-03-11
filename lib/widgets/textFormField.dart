import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  TextEditingController myController;
  String textHint;
  CustomTextForm(
      {super.key, required this.textHint, required this.myController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        alignLabelWithHint: true,
        labelText: textHint,
      ),
    );
  }
}
