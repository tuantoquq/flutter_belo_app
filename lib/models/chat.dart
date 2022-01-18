class ChatCardModel {
  String username;
  String lastMessage;
  String lastSendTime;
  String partnerName;
  String partnerId;
  String chatId;

  ChatCardModel(
      {required this.username,
      required this.lastMessage,
      required this.lastSendTime,
      required this.partnerName,
      required this.chatId,
      required this.partnerId});
  ChatCardModel.fromJson(Map<String, dynamic> json)
      : username = json['user']['username'].toString(),
        lastMessage = json['content'].toString(),
        lastSendTime = json['updatedAt'].toString(),
        partnerName = json['partnerName'].toString(),
        chatId = json['chat']['_id'].toString(),
        partnerId = json['partnerId'].toString();
}

class ChatDetailModel {
  String senderId;
  String sendTime;
  String content;
  String currentUser;

  ChatDetailModel(
      {required this.senderId,
      required this.sendTime,
      required this.content,
      required this.currentUser});
  ChatDetailModel.fromJson(Map<String, dynamic> json)
      : senderId = json['user']['_id'].toString(),
        sendTime = json['updatedAt'].toString(),
        content = json['content'].toString(),
        currentUser = json['currentId'].toString();
}

class MessagesChat {
  String receivedName;
  String chatId;
  String receivedId;
  String type;
  String content;

  MessagesChat(
      {required this.receivedName,
      required this.receivedId,
      required this.chatId,
      required this.content,
      this.type = "PRIVATE_CHAT"});
}
