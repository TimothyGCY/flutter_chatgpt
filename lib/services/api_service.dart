import 'dart:convert';
import 'dart:developer';

import 'package:chatgpt/models/api_model.dart';
import 'package:chatgpt/models/message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final key = dotenv.env['API_KEY'];
const String domain = 'https://api.openai.com/v1';
final headers = <String, String>{
  'Authorization': 'Bearer $key',
};

class APIService {
  static final _client = http.Client();

  static post(String endpoint, {required Map<String, dynamic> body}) async {
    try {
      http.Response response = await _client.post(
        Uri.parse('$domain$endpoint'),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  static get(String endpoint) async {
    try {
      http.Response res =
          await _client.get(Uri.parse('$domain$endpoint'), headers: headers);
      return jsonDecode(res.body);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<List<APIModel>> getModels() async {
    var response = await get('/models');
    return APIModel.fromSnapshot(response['data']);
  }

  static Future<Message> submitQuery(String model, String query) async {
    Map<String, dynamic> body = {
      'model': model,
      'prompt': query,
      'max_tokens': 1024,
      'temperature': 0.7,
    };
    var response = await post('/completions', body: body);
    return Message.fromJson(response);
  }
}
