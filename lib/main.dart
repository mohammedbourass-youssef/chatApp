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
        ChatScreen.id: (context) => ChatScreen(),
      },
      initialRoute: 'login',
    );
  }
}
