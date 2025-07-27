import 'dart:convert';

import 'package:kawika_test/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _userKey = 'user_data';

  // save user data locally
  saveUserData(UserDataModel userData) async {
    final prefs = await SharedPreferences.getInstance();
    final String userDataJson = jsonEncode(userData);
    await prefs.setString(_userKey, userDataJson);
  }

  // get local user data
  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      final data = jsonDecode(userJson);
      final UserDataModel user = UserDataModel.fromJson(data);
      return user;
    }
    return null;
  }

  // clear user data
  clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
