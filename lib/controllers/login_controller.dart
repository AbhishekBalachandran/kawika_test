import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kawika_test/common/apis/apis.dart';
import 'package:kawika_test/common/apis/widgets/widgets.dart';
import 'package:kawika_test/models/user_model.dart';
import 'package:kawika_test/pages/navigation_menu/navigation_menu.dart';
import 'package:kawika_test/preferences/preferences.dart';

class LoginController with ChangeNotifier {
  bool isVisibilityOff = true;
  bool loading = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  changeVisibility() {
    isVisibilityOff = !isVisibilityOff;
    notifyListeners();
  }

  // login
  login(BuildContext context) async {
    final url = Uri.parse(Apis.login);
    final body = {
      "username": usernameController.text,
      "password": passwordController.text,
    };
    loading = true;
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final userData = UserDataModel.fromJson(responseData);
        try {
          Preferences().saveUserData(userData);
        } catch (e) {
          throw Exception('Failed to save locally');
        }
        debugPrint('Logged in successfully');
        customSnackbar(context, content: 'Logged In Successfully');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationMenu()),
          (route) => false,
        );
      } else {
        customSnackbar(context, content: 'Failed to login');
        throw Exception('Failed to login');
      }
    } catch (e) {
      customSnackbar(context, content: 'Failed to login');
      throw Exception('Error login $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
