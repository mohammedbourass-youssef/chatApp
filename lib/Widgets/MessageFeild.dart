import 'package:chat_app/Constants.dart';
import 'package:flutter/material.dart';

class Messagefeild extends StatelessWidget {
  Messagefeild({super.key, required this.onPressed ,required this.controller});
  final Function(String? value) onPressed;
  String? _message;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: TextField(
        onChanged: (value) {
          _message = value;
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Type your message',
          hintStyle: TextStyle(color: kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kPrimaryColor, width: 2),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              onPressed(_message);
            },
            child: Icon(Icons.send, color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
