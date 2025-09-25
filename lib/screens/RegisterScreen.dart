import 'package:chat_app/Classes/MessageBox.dart';
import 'package:chat_app/Constants.dart';
import 'package:chat_app/Globalitems.dart';
import 'package:chat_app/Models/UserModal.dart';
import 'package:chat_app/Widgets/EntrerScreen.dart';
import 'package:chat_app/screens/ContactScreen.dart';
import 'package:chat_app/screens/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? username;
  String? password;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Entrerscreen(
        onUsernameChanged: (value) {
          username = value;
        },
        isRegister: true,
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
            FirebaseFirestore.instance.collection(kusersCollection).add({
              'email': email,
              'username': username,
              'userId': userCredential.user?.uid,
            });
            loggedinuser = Usermodal(
              email: email,
              username: username,
              id: userCredential.user?.uid,
            );
            Navigator.pushNamed(context, Contactscreen.id);
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
