import 'package:flutter/material.dart';

class APIModel {
  const APIModel({
    Key? key,
    required this.id,
    required this.created,
    required this.root,
  });

  final String id;
  final int created;
  final String root;

  factory APIModel.fromJson(Map<String, dynamic> json) => APIModel(
        key: Key(json['id']),
        id: json['id'],
        created: json['created'],
        root: json['root'],
      );

  static List<APIModel> fromSnapshot(List<dynamic> snapshot) {
    return snapshot.map((data) => APIModel.fromJson(data)).toList();
  }
}
