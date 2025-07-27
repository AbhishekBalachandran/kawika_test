import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kawika_test/common/apis/apis.dart';
import 'package:kawika_test/models/data_model.dart';

class HomeControllers with ChangeNotifier {
  bool loading = false;
  List<DataListModel> dataList = [];

  // get data list
  getDataList() async {
    final url = Uri.parse(Apis.dataList);
    dataList = [];
    loading = true;
    try {
      final response = await http.get(url);
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List<dynamic>;
        dataList = responseData
            .map((data) => DataListModel.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to fetch data list');
      }
    } catch (e) {
      throw Exception('Error fetching data list');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
