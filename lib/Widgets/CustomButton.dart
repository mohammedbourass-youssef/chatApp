import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
 const Custombutton({super.key, this.buttonText , this.onPressed});
  final String? buttonText;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        child:Center(
          child: Text(
            buttonText ?? 'Sign In',
            style: TextStyle(
              fontFamily: 'Trajan Pro',
              fontSize: 20,
              color: Color(0xFF274460),
            ),
          ),
        ),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
      onTap: () {
        onPressed?.call();
      },
    );
  }
}
