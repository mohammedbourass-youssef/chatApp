import 'package:chat_app/Classes/MessageBox.dart';
import 'package:chat_app/Globalitems.dart';
import 'package:chat_app/Models/UserModal.dart';
import 'package:chat_app/Widgets/EntrerScreen.dart';
import 'package:chat_app/screens/ContactScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});
  static const id = 'login';

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String? email;

  String? password;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Entrerscreen(
        buttonText: 'LogIn',
        clickmessage: 'Sign Up',
        message: 'Don\'t have an account?',
        pagename: 'Log In',
        onRoutePressed: () {
          Navigator.pushNamed(context, 'register');
        },
        onConfiremed: () async {
          try {
            isloading = true;
            setState(() {});
            final credential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email!, password: password!);
            
            loggedinuser = await Usermodal.fromEmail(email!);
            if (loggedinuser != null) {
              Navigator.pushNamed(context, Contactscreen.id);
            } else {
              Messagebox.show(
                context,
                'falied to enter try again',
                Enstatus.failled,
              );
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              Messagebox.show(
                context,
                'No user found for that email.',
                Enstatus.failled,
              );
            } else if (e.code == 'wrong-password') {
              Messagebox.show(
                context,
                'Wrong password provided for that user.',
                Enstatus.failled,
              );
            }
            else{
               Messagebox.show(
                context,
                'Error',
                Enstatus.failled,
              );
            }
          }
          isloading = false;
          setState(() {});
        },
        onEmailChanged: (value) {
          email = value;
        },
        onPasswordChanged: (value) {
          password = value;
        },
      ),
    );
  }
}
