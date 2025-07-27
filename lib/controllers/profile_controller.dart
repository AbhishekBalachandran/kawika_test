import 'package:flutter/material.dart';
import 'package:kawika_test/models/user_model.dart';
import 'package:kawika_test/preferences/preferences.dart';

class ProfileController with ChangeNotifier {
  bool isLoading = false;
  UserDataModel? userData;

  // load user data
  loadUserData() async {
    isLoading = true;
    try {
      final user = await Preferences().getUserData();
      userData = user;
    } catch (e) {
      throw Exception('Failed to load user data');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // logout

  logout() async {
    isLoading = true;
    try {
      Preferences().clearUserData();
      return true;
    } catch (e) {
      throw Exception('Failed to. logout $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
