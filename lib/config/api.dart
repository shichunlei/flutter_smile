import 'dart:async';

import 'package:http/http.dart' as http;

class APIs {
  static Future<dynamic> getData(String baseUrl,
      {Map<String, dynamic> params, Map<String, String> headers}) async {
    print("baseUrl ============> $baseUrl");

    http.Response response = await http.get(
      baseUrl,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print("response.body ===========> ${response.body}");

      return response.body;
    } else {
      return null;
    }
  }

  static Future<String> postData(String baseUrl,
      {dynamic body, Map<String, String> headers}) async {
    print("baseUrl ============> $baseUrl");
    print("body =============> ${body.toString()}");

    http.Response response = await http.post(
      baseUrl,
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print("response.body ===========> ${response.body}");

      return response.body;
    } else {
      return null;
    }
  }
}
