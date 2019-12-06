import 'dart:convert' as convert;

import 'package:webdriver_framework/src/http_request.dart';

class Element {
  final String sessionURL;
  final String elementId;
  Element({String host, String sessionId, this.elementId})
      : sessionURL = "${host}/session/${sessionId}/element/$elementId";

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
