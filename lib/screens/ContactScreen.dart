import 'package:chat_app/Constants.dart';
import 'package:chat_app/Globalitems.dart';
import 'package:chat_app/Models/ContactInfo.dart';
import 'package:chat_app/Widgets/ContactInfo.dart';
import 'package:chat_app/screens/FindUserScreen.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Contactscreen extends StatefulWidget {
  const Contactscreen({super.key});
  static const id = 'contact';

  @override
  State<Contactscreen> createState() => _ContactscreenState();
}

class _ContactscreenState extends State<Contactscreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(kchatscollection)
          .where('chaters', arrayContains: loggedinuser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          floatingActionButton: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Finduserscreen.id);
              },
              icon: Icon(Icons.add, color: Colors.white, size: 26),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  //implemeted later
                },
              ),
            ],
            title: const Text(
              'Chats',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
          ),

          body: (snapshot.data == null)
              ? Text('there is no chats please to try to add new ones')
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var c = ContactinfoModal(
                      contactID: snapshot.data!.docs[index].id,
                      emailReceiver: snapshot.data!.docs[index]['chaters'][0],
                      emailSender: snapshot.data!.docs[index]['chaters'][1],
                      lastMessage: '',
                      lastmessageDate: DateTime.now(),
                      showNotifyIcon: snapshot.data!.docs[index]['NewMessages'],
                    );
                    
                   
                    return ContactItem(
                      contact: c,
                      onClicked: () async {
                        
                        Navigator.pushNamed(
                          context,
                          ChatScreen.id,
                          arguments: c,
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
