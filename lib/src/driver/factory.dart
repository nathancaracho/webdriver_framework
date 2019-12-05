import 'dart:convert' as convert;

import 'package:webdriver_framework/src/driver/drivers.dart';
import 'package:webdriver_framework/src/http_request.dart';

import 'exceptions.dart';

Future<Webdriver> webdriverFactory({int port, String host}) async {
  String sessionId;
  Webdriver driver;
  String url = "$host:$port";
  try {
    var body = convert.jsonEncode({"desiredCapabilities": {}});
    sessionId =
        (await HTTPRequest.post("$url/session", body))["sessionId"].toString();
    if (sessionId.isNotEmpty)
      driver = Driver(host: url, sessionId: sessionId);
    else
      throw NoSessionCreate("The session was not create");
  } catch (ex) {
    throw NoSessionCreate(ex.message);
  }

  return driver;
}
