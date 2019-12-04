import 'dart:io';
import 'dart:convert' as convert;

Future webdriverServer(int port) async {
  HttpServer server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  server.listen((HttpRequest request) {
    switch (request.uri.toString()) {
      case "/session":
        request.response
            .write(convert.jsonEncode({"sessionId": "1234567", "status": 0}));
    }
    request.response.close();
  });
}
