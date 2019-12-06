import 'dart:convert' as convert;

import 'package:webdriver_framework/src/element.dart';
import 'package:webdriver_framework/src/by.dart';
import 'package:webdriver_framework/src/http_request.dart';

class _DriverCommand {
  String _urlSession;
  _DriverCommand(String host, String sessionId)
      : _urlSession = "$host/session/$sessionId";

  String navigateTo() => "${this._urlSession}/url";
  String getElement() => "${this._urlSession}/element";
  String get urlSesssion => _urlSession;
}

abstract class Webdriver {
  final String sessionId;
  final String host;
  _DriverCommand commands;
  Webdriver({this.host, this.sessionId});

  Future navigateTo(String url);

  Future<Element> findElement(By el);

  Future<String> _findElement(By el);

  Future close();
}

class Driver implements Webdriver {
  final String sessionId;
  final String host;
  _DriverCommand commands;

  Driver({this.host, this.sessionId})
      : commands = _DriverCommand(host, sessionId);

  Future navigateTo(String url) async {
    var body = convert.jsonEncode({"url": url});
    await HTTPRequest.post(commands.navigateTo(), body);
  }

  Future<Element> findElement(By el) async {
    String elID = await _findElement(el);
    return Element(
      host: this.host,
      elementId: elID,
      sessionId: this.sessionId,
    );
  }

  Future<String> _findElement(By el) async {
    var body = convert.jsonEncode({"using": el.using, "value": el.value});
    var element = await HTTPRequest.post(commands.getElement(), body);
    return element["value"]["ELEMENT"];
  }

  Future close() async {
    await requestWrapper((client) async {
      client.delete(commands.urlSesssion);
    });
  }
}
