import "package:test/test.dart";
import 'package:webdriver_framework/webdriver.dart';

import 'mock/webdriver_server.dart';

const int port = 1313;
const String host = "http://localhost";

void main() async {
  await webdriverServer(port);
  group("Webdriver", () {
    test("Not create session", () async {
      try {
        await webdriverFactory(port: 9090, host: host);
      } catch (ex) {
        expect((ex is NoSessionCreate), isTrue);
      }
    });
    test("Webdriver: object create", () async {
      Webdriver webdriver = await webdriverFactory(port: port, host: host);
      expect(webdriver, isNotNull);
    });
  });
}
