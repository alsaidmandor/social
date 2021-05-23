class MessageModel {
  String senderId;
  String receiverId;
  String text;
  String datetime;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.text,
    this.datetime,
  });

  MessageModel.fromJson({Map<String, dynamic> json}) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'datetime': datetime,
    };
  }
}
