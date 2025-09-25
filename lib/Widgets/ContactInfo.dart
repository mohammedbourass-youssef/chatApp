import 'package:chat_app/Constants.dart';
import 'package:chat_app/Globalitems.dart';
import 'package:chat_app/Models/ContactInfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactItem extends StatelessWidget {
  ContactItem({super.key, required this.contact, required this.onClicked});
  final ContactinfoModal contact;
  final VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),

              child: Icon(
                Icons.person_2_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            Column(
              children: [
                Text(
                  contact.emailReceiver == loggedinuser!.email!
                      ? contact.emailSender
                      : contact.emailReceiver,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('No informations'),
              ],
            ),
            Column(
              children: [
                Text(DateFormat('HH:mm').format(contact.lastmessageDate)),
                Icon(Icons.feedback_outlined, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
