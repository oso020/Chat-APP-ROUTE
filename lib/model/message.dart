class Message {
  static const String messageCollection = "message";
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  DateTime dateTime;

  Message({
    this.id = "",
    required this.roomId,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.dateTime,
  });

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"] as String,
          roomId: json["roomId"] as String,
          content: json["content"] as String,
          senderId: json["senderId"] as String,
          senderName: json["senderName"] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(json["dateTime"]) as DateTime ,
        );

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "roomId": roomId,
      "content": content,
      "senderId": senderId,
      "senderName": senderName,
      "dateTime": dateTime.millisecondsSinceEpoch,
    };
  }
}
