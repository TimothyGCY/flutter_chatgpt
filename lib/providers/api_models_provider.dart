import 'package:chatgpt/models/api_model.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/material.dart';

class APIModelProvider with ChangeNotifier {
  List<APIModel> _modelList = [];
  String _currentModel = 'text-davinci-001';

  List<APIModel> get models => _modelList;

  String get currentModel => _currentModel;

  void setModel(String model) {
    _currentModel = model;
    notifyListeners();
  }

  Future<List<APIModel>> getAllModels() async {
    _modelList = await APIService.getModels();
    return models;
  }
}
