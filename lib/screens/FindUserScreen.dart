import 'package:chat_app/Constants.dart';
import 'package:chat_app/Models/UserModal.dart';
import 'package:chat_app/Widgets/UserContactFound.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Finduserscreen extends StatefulWidget {
  const Finduserscreen({super.key});
  static const String id = 'finduser';

  @override
  State<Finduserscreen> createState() => _FinduserscreenState();
}

class _FinduserscreenState extends State<Finduserscreen> {
  String x = '';
  void filter(value) {
    setState(() {
      x = value;
    });
  }

  CollectionReference messagesCollections = FirebaseFirestore.instance
      .collection(kusersCollection);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messagesCollections
          .where('username', isGreaterThanOrEqualTo: x) // start
          .where('username', isLessThan: '$x\uf8ff')
          .snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Find Users',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(30),
                child: TextField(
                  onChanged: (value) => filter(value),
                  decoration: InputDecoration(
                    hintText: 'enter username',
                    focusColor: kPrimaryColor,
                  ),
                ),
              ),
              snapshot.data == null
                  ? Center(
                      child: Text(
                        'No user found Try again,check your connection',
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return UserContactFound(
                            usermodal: Usermodal(
                              email: snapshot.data!.docs[index]['email'],
                              id: snapshot.data!.docs[index]['userId'],
                              username: snapshot.data!.docs[index]['username'],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
