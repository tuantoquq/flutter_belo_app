import 'package:belo_app/models/user.dart';
import 'package:belo_app/provider/api.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  List<UserProfile> _rsSearchUser = [];

  List<UserProfile> get rsSearchUser {
    return [..._rsSearchUser];
  }

  Future<void> seachUser(String query) async {
    try {
      dynamic response = await Api.searchUser(await Util.getToken(), query);
      _rsSearchUser = response['data']
          .map<UserProfile>((c) => UserProfile.fromJson(c))
          .toList();
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
