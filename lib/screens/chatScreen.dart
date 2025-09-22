import 'package:chat_app/Classes/MessageBox.dart';
import 'package:chat_app/Constants.dart';
import 'package:chat_app/Globalitems.dart';
import 'package:chat_app/Models/MessageModel.dart';
import 'package:chat_app/Widgets/ChatBuble.dart';
import 'package:chat_app/Widgets/MessageFeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  static String id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

List<Messagemodel> messages = [];

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messagesCollections = FirebaseFirestore.instance
      .collection(kMessageCollection);
  final TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(kMessageCollection)
          .orderBy(Messagemodel.createdatfeild, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(kLogo, height: 50),
                Text(' Chat', style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: kPrimaryColor,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              Expanded(
                child: snapshot.data == null
                    ? Text('Loading . . .')
                    : ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
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
                      Messagemodel.senderfeild: loggedinuser?.email,
                    });
                    controller.clear();
                    _controller.animateTo(
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
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
