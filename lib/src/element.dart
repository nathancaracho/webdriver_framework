import 'dart:convert' as convert;

import 'package:webdriver_framework/src/http_request.dart';

class Element {
  final String sessionURL;

  Element({this.sessionURL});

  Future setValue(String value) async {
    await HTTPRequest.post(
        "${this.sessionURL}/value",
        convert.jsonEncode({
          "type": "",
          "data": value,
          "value": [value]
        }));
  }

  Future click() async {
    await HTTPRequest.post("${this.sessionURL}/click", null);
  }

  Future submit() async {
    await HTTPRequest.post("${this.sessionURL}/submit", null);
  }
}
