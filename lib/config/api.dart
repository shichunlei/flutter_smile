import 'dart:async';

import 'package:http/http.dart' as http;

class APIs {
  static Future<dynamic> getData(String baseUrl,
      {Map<String, String> headers}) async {
    http.Response response = await http.get(
      baseUrl,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String> postData(String baseUrl,
      {dynamic body, Map<String, String> headers}) async {
    http.Response response = await http.post(
      baseUrl,
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
