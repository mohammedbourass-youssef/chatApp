import 'package:chat_app/Constants.dart';
import 'package:chat_app/Globalitems.dart';
import 'package:chat_app/Models/ContactInfo.dart';
import 'package:chat_app/Models/UserModal.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserContactFound extends StatelessWidget {
  UserContactFound({super.key, required this.usermodal});
  final Usermodal usermodal;
  CollectionReference chatsCollections = FirebaseFirestore.instance.collection(
    kchatscollection,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 20),
      child: GestureDetector(
        onTap: () async {
          var userchats = await chatsCollections
              .where('chaters', arrayContains: loggedinuser!.email)
              .get();

          // Filter chats that also contain the second user
          var matchingChats = userchats.docs
              .where(
                (doc) => (doc['chaters'] as List).contains(usermodal.email),
              )
              .toList();
          var docs;
          if (matchingChats.isEmpty) {
            // No chat exists → create new
            docs = await chatsCollections.add({
              'chaters': [usermodal.email, loggedinuser!.email],
              'NewMessages': true,
            });
          } else {
            // Use the existing chat
            docs = matchingChats.first;
          }
          // Navigate to chat screen with the contact info
          Navigator.pushNamed(
            context,
            ChatScreen.id,
            arguments: ContactinfoModal(
              emailReceiver: usermodal.email!,
              emailSender: loggedinuser!.email!,
              lastMessage: 'added you to his text',
              lastmessageDate: DateTime.now(),
              showNotifyIcon: true,
              contactID: docs.id,
              receiverUser: await Usermodal.fromEmail(usermodal.email!),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10, left: 20),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: kPrimaryColor,
                ),
                child: Icon(Icons.person, color: Colors.white),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${usermodal.username}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text('${usermodal.email}', style: TextStyle(fontSize: 17)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
