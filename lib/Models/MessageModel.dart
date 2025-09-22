class Messagemodel {
  static const String messagefeild = 'text';
  static const String senderfeild = 'sender';
  static const String createdatfeild = 'createdAt';

  String? message;
  String? sender;
  DateTime? createdAt;

  Messagemodel({this.message, this.sender, this.createdAt});

  factory Messagemodel.FromJson(jsondata) {
    return Messagemodel(
      message: jsondata[messagefeild],
      sender: jsondata[senderfeild],
      createdAt: jsondata[createdatfeild],
    );
  }
}
