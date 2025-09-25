import 'package:chat_app/Models/UserModal.dart';

class ContactinfoModal {
  String contactID;
  String emailSender;
  String emailReceiver;
  String lastMessage;
  DateTime lastmessageDate;
  bool showNotifyIcon;
  Usermodal? receiverUser;
  ContactinfoModal({
    required this.emailReceiver,
    required this.emailSender,
    required this.lastMessage,
    required this.lastmessageDate,
    required this.showNotifyIcon,
    required this.contactID,
    this.receiverUser,
  });
}
