import 'package:flutter/material.dart';

class Custom_TextFeild extends StatelessWidget {
  const Custom_TextFeild({this.hintText, super.key, this.onChanged});
  final String? hintText;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText ?? 'Enter your text',
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
