import 'package:belo_app/models/chat.dart';
import 'package:belo_app/provider/api.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:flutter/material.dart';

class Chats extends ChangeNotifier {
  List<ChatCardModel> _listChats = [];
  List<ChatDetailModel> _listMessages = [];
  Future<void> getListChats() async {
    try {
      dynamic response = await Api.getListMessageCard(await Util.getToken());
      _listChats = response['data']
          .map<ChatCardModel>((c) => ChatCardModel.fromJson(c))
          .toList();
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> getListMessagesOfChat(String chatId) async {
    try {
      dynamic response = await Api.getListMessagesOfChat(await Util.getToken(), chatId);
      _listMessages = response['data']
          .map<ChatDetailModel>((c) => ChatDetailModel.fromJson(c))
          .toList();
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  List<ChatCardModel> get listChats {
    return [..._listChats];
  }

  List<ChatDetailModel> get listMessages {
    return [..._listMessages];
  }
}
