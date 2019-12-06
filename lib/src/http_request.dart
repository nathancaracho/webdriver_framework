import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future requestWrapper(Function request) async {
  var client = http.Client();
  try {
    await request(client);
  } catch (ex) {
    print(ex);
  } finally {
    client.close();
  }
}

abstract class HTTPRequest {
  static Future<dynamic> post(String url, Object body) async {
    var client = http.Client();
    try {
      return _getObject(await client.post(url, body: body));
    } catch (ex) {
      throw ex;
    } finally {
      client.close();
    }
  }

  static Future<dynamic> get(String url) async {
    var client = http.Client();
    try {
      return _getObject(await client.get(url));
    } catch (ex) {
      throw ex;
    } finally {
      client.close();
    }
  }

  static Future<dynamic> delete(String url) async {
    var client = http.Client();
    try {
      return _getObject(await client.delete(url));
    } catch (ex) {
      throw ex;
    } finally {
      client.close();
    }
  }

  static Future<dynamic> put(String url, Object body) async {
    var client = http.Client();
    try {
      return _getObject(await client.put(url, body: body));
    } catch (ex) {
      throw ex;
    } finally {
      client.close();
    }
  }

  static Object _getObject(http.Response reponse) {
    var body = convert.jsonDecode(reponse.body);
    if (body["status"] != 0) throw body["value"]["message"];
    return body;
  }
}
