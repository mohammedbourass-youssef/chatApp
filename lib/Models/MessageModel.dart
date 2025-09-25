class Messagemodel {
  static const String messagefeild = 'text';
  static const String ChatIDfeild = 'chatID';
  static const String createdatfeild = 'createdAt';
  static const String senderfeild = 'senderEmail';

  String message;
  String chatID;
  DateTime createdAt;
  String senderEmail;

  Messagemodel({
    required this.message,
    required this.chatID,
    required this.createdAt,
    required this.senderEmail,
  });

  factory Messagemodel.FromJson(jsondata) {
    return Messagemodel(
      message: jsondata[messagefeild],
      chatID: jsondata[ChatIDfeild],
      createdAt: jsondata[createdatfeild],
      senderEmail: jsondata[senderfeild],
    );
  }
}
