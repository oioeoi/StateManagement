import 'package:flutter/material.dart';
import 'package:themeDataAndBloc/services/http_services.dart';

class HttpProvider with ChangeNotifier {
  bool isLoading = false;

  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;
  int get countData => _data.length;

  Future<void> responApi(String name, String job) async {
    isLoading = true;
    notifyListeners();
    final response = await HttpService.connectAPI(name, job);

    _data = response as Map<String, dynamic>;
    isLoading = false;
    notifyListeners();
  }
}
