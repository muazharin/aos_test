import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class GlobalService {
  Future post(path, body) async {
    Uri url = Uri.parse("$path");
    print(url);
    print(body);
    try {
      return await http
          .post(url, body: body)
          .timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      throw 'Request Timeout';
    } on SocketException catch (_) {
      throw 'Unable to access server';
    } catch (e) {
      throw 'Error: ' + e.toString();
    }
  }

  Future get(path) async {
    Uri url = Uri.parse("$path");
    print(url);
    try {
      return await http.get(url).timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      throw 'Request Timeout';
    } on SocketException catch (_) {
      throw 'Unable to access server';
    } catch (e) {
      throw 'Error: ' + e.toString();
    }
  }
}
