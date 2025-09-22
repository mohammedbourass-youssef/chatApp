import 'package:chat_app/Constants.dart';
import 'package:chat_app/Widgets/CustomButton.dart';
import 'package:chat_app/Widgets/custom_TextFeild.dart';
import 'package:flutter/material.dart';

class Entrerscreen extends StatelessWidget {
   Entrerscreen({
    super.key,
    required this.pagename,
    required this.buttonText,
    required this.message,
    required this.clickmessage,
    required this.onRoutePressed,
    required this.onConfiremed,
    this.onEmailChanged,
    this.onPasswordChanged,
  });
  final String? pagename;
  final String? buttonText;
  final String? message;
  final String? clickmessage;
  final VoidCallback? onRoutePressed;
  final VoidCallback? onConfiremed;
  final Function(String)? onEmailChanged;
  final Function(String)? onPasswordChanged;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Spacer(flex: 1),
              Image.asset('lib/assets/images/scholar.png'),
              Text(
                'Scholar Chat',
                style: TextStyle(
                  fontFamily: 'Trajan Pro',
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              Spacer(flex: 1),
              Padding(
                padding: EdgeInsetsGeometry.all(9),
                child: Align(
                  child: Text(
                    pagename ?? 'Log In',
                    style: TextStyle(
                      fontFamily: 'Trajan Pro',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  alignment: AlignmentGeometry.topLeft,
                ),
              ),

              Custom_TextFeild(hintText: 'Email', onChanged: onEmailChanged),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 9),
                child: Custom_TextFeild(
                  hintText: 'Password',
                  onChanged: onPasswordChanged,
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                child: Custombutton(
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                         onConfiremed?.call();
                    }

                  },
                  buttonText: buttonText ?? 'Sign In',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message ?? 'Don\'t have an account?',
                    style: TextStyle(
                      fontFamily: 'Trajan Pro',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      '  $clickmessage',
                      style: TextStyle(
                        fontFamily: 'Trajan Pro',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      onRoutePressed?.call();
                    },
                  ),
                ],
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
