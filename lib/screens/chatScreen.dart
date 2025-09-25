import 'package:chat_app/Classes/MessageBox.dart';
import 'package:chat_app/Constants.dart';
import 'package:chat_app/Globalitems.dart';
import 'package:chat_app/Models/ContactInfo.dart';
import 'package:chat_app/Models/MessageModel.dart';
import 'package:chat_app/Widgets/ChatBuble.dart';
import 'package:chat_app/Widgets/MessageFeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.contact});
  static String id = 'chatScreen';
  final ContactinfoModal contact;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messagesCollections = FirebaseFirestore.instance
      .collection(kMessageCollection);
  final TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: messagesCollections
          .orderBy(Messagemodel.createdatfeild, descending: true)
          .where(Messagemodel.ChatIDfeild, isEqualTo: widget.contact.contactID)
          .snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                widget.contact.receiverUser == null
                    ? 'Annonymous'
                    : widget.contact.receiverUser!.username ?? 'Anonymous',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: kPrimaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                child: snapshot.data == null || snapshot.data!.docs.isEmpty
                    ? const Center(
                        child: Text("No messages, try to send 'Hello'"),
                      )
                    : ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No messages, try to send 'Hello'"),
                            );
                          }
                          return snapshot.data!.docs[index][Messagemodel
                                      .senderfeild] ==
                                  loggedinuser?.email
                              ? Chatbuble(
                                  message: snapshot
                                      .data!
                                      .docs[index][Messagemodel.messagefeild]
                                      .toString(),
                                )
                              : ChatbubleForFreind(
                                  message: snapshot
                                      .data!
                                      .docs[index][Messagemodel.messagefeild]
                                      .toString(),
                                );
                        },
                      ),
              ),
              Messagefeild(
                controller: controller,
                onPressed: (value) {
                  if (value != null && value.isNotEmpty) {
                    messagesCollections.add({
                      Messagemodel.messagefeild: value,
                      Messagemodel.createdatfeild: DateTime.now(),
                      Messagemodel.ChatIDfeild: widget.contact.contactID,
                      Messagemodel.senderfeild: loggedinuser?.email,
                    });
                    controller.clear();
                    if (_controller.hasClients) {
                      _controller.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    }
                  } else {
                    Messagebox.show(
                      context,
                      'can not send an empty message!',
                      Enstatus.failled,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
