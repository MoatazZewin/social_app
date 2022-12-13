
class MessageModel{
  String? text;
  String? senderId;
  String? receiverId;
  dynamic dateTime;


  MessageModel({this.text, this.senderId, this.receiverId,this.dateTime});

  MessageModel.fromJson(Map<String, dynamic>? json)
  {

    text = json!['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];

  }
  Map<String, dynamic> toMap()
  {
    return {
      'text':text,
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,

    };


  }
}