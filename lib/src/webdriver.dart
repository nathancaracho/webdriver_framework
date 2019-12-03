import 'dart:convert' as convert;

import 'package:webdriver_framework/src/element.dart';
import 'package:webdriver_framework/src/by.dart';
import 'package:webdriver_framework/src/http_request.dart';

import '../webdriver.dart';

class Webdriver {
  String _sessionId;
  final String host;
  final int port;
  final String url;
  Webdriver({this.port, this.host}) : this.url = "${host}:${port}";

  Future sessionCreate() async {
    var body = convert.jsonEncode({"desiredCapabilities": {}});
    this._sessionId =
        (await HTTPRequest.post("${this.url}/session", body))["sessionId"]
            .toString();
  }

  Future navigateTo(String url) async {
    var body = convert.jsonEncode({"url": url});
    await HTTPRequest.post("${this.url}/session/${this._sessionId}/url", body);
  }

  Future<Element> findElement(By el) async {
    String elID = await _findElement(el);
    return Element(
        sessionURL: "${this.url}/session/${this._sessionId}/element/$elID");
  }

  Future<String> _findElement(By el) async {
    var body = convert.jsonEncode({"using": el.using, "value": el.value});
    var element = await HTTPRequest.post(
        "${this.url}/session/${this._sessionId}/element", body);
    return element["value"]["ELEMENT"];
  }

  Future close() async {
    await requestWrapper((client) async {
      client.delete("${this.url}/session/${this._sessionId}");
    });
  }
}
