import 'package:belo_app/models/user.dart';
import 'package:belo_app/provider/api.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:flutter/material.dart';

class Friends extends ChangeNotifier {
  List<UserProfile> _listFriend = [];
  List<UserProfile> _listReceivedFriend = [];

  List<UserProfile> get listFriend {
    return [..._listFriend];
  }

  List<UserProfile> get listReceivedFriend {
    return [..._listReceivedFriend];
  }

  Future<void> getListFriend() async {
    try {
      dynamic response = await Api.getListFriend(await Util.getToken());
      _listFriend = response['data']['friends']
          .map<UserProfile>((f) => UserProfile.fromJson(f))
          .toList();
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> getListReceivedFriend() async {
    try {
      dynamic response = await Api.getListReceivedFriend(await Util.getToken());
      _listReceivedFriend = response['data']['friends']
          .map<UserProfile>((f) => UserProfile.fromJson(f))
          .toList();
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
