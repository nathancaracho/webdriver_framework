import 'dart:convert' as convert;

import 'package:webdriver_framework/src/element.dart';
import 'package:webdriver_framework/src/by.dart';
import 'package:webdriver_framework/src/http_request.dart';

import '../webdriver.dart';

Future<Webdriver> webdriverFactory({int port, String host}) async {
  String sessionId;
  Webdriver webdriver;
  String url = "$host:$port";
  try {
    var body = convert.jsonEncode({"desiredCapabilities": {}});
    sessionId =
        (await HTTPRequest.post("$url/session", body))["sessionId"].toString();
    if (sessionId.isNotEmpty)
      webdriver = Webdriver(url: url, sessionId: sessionId);
    else
      throw NoSessionCreate("The session was not create");
  } catch (ex) {
    throw NoSessionCreate(ex.message);
  }

  return webdriver;
}

class Webdriver {
  final String sessionId;
  final String url;
  Webdriver({this.url, this.sessionId});

  Future navigateTo(String url) async {
    var body = convert.jsonEncode({"url": url});
    await HTTPRequest.post("${this.url}/session/${this.sessionId}/url", body);
  }

  Future<Element> findElement(By el) async {
    String elID = await _findElement(el);
    return Element(
        sessionURL: "${this.url}/session/${this.sessionId}/element/$elID");
  }

  Future<String> _findElement(By el) async {
    var body = convert.jsonEncode({"using": el.using, "value": el.value});
    var element = await HTTPRequest.post(
        "${this.url}/session/${this.sessionId}/element", body);
    return element["value"]["ELEMENT"];
  }

  Future close() async {
    await requestWrapper((client) async {
      client.delete("${this.url}/session/${this.sessionId}");
    });
  }
}

class NoSessionCreate implements Exception {
  final String cause;
  NoSessionCreate(this.cause);
}
