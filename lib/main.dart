import 'package:chat_app/Models/ContactInfo.dart';
import 'package:chat_app/screens/ContactScreen.dart';
import 'package:chat_app/screens/FindUserScreen.dart';
import 'package:chat_app/screens/LoginScreen.dart';
import 'package:chat_app/screens/RegisterScreen.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Loginscreen.id: (context) => Loginscreen(),
        Registerscreen.id: (context) => Registerscreen(),
        ChatScreen.id: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as ContactinfoModal;
          return ChatScreen(contact: args);
        },
        Contactscreen.id: (context) => Contactscreen(),
        Finduserscreen.id: (context) => const Finduserscreen(),
      },
      initialRoute: 'login',
    );
  }
}
