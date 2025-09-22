import 'package:chat_app/Classes/MessageBox.dart';
import 'package:chat_app/Widgets/EntrerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registerscreen extends StatefulWidget {
  Registerscreen({super.key});
  static const id = 'register';

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  String? email;

  String? password;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Entrerscreen(
        buttonText: 'Sign Up',
        clickmessage: 'Log In',
        message: 'Already have an account?',
        pagename: 'Sign Up',
        onRoutePressed: () {
          Navigator.pop(context);
        },
        onConfiremed: () async {
          isloading = true;
          setState(() {});
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                  email: email!,
                  password: password!,
                );
            Messagebox.show(
              context,
              'the Account created Succefully',
              Enstatus.succes,
            );
            Navigator.pushNamed(context, 'chatScreen');
          } on FirebaseAuthException catch (ex) {
            if (ex.code == 'weak-password') {
              Messagebox.show(
                context,
                'Error : Week password Try another one',
                Enstatus.failled,
              );
              if (ex.code == 'email-already-in-use') {
                Messagebox.show(
                  context,
                  'The email is already registered by another account.',
                  Enstatus.failled,
                );
              }
            }
          } catch (e) {
            Messagebox.show(context, e.toString(), Enstatus.failled);
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
