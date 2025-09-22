import 'package:chat_app/Constants.dart';
import 'package:flutter/material.dart';

class Chatbuble extends StatelessWidget {
  const Chatbuble({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      ),
    );
  }
}

class ChatbubleForFreind extends StatelessWidget {
  const ChatbubleForFreind({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      ),
    );
  }
}
