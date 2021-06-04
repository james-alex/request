import 'dart:convert';
import 'package:http/http.dart' hide get, post;
import 'request.dart' as http;

extension RequestUri on Uri {
  /// {@macro request.get}
  ///
  /// {@macro request.httpStatusException}
  Future<Response> get({Map<String, String>? headers}) async =>
      http.get(this, headers: headers);

  /// {@macro request.request}
  ///
  /// {@macro request.httpStatusException}
  Future<String> request({Map<String, String>? headers}) async =>
      http.request(this, headers: headers);

  /// {@macro request.post}
  ///
  /// {@macro request.httpStatusException}
  Future<Response> post({
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async => http.post(this, headers: headers, body: body, encoding: encoding);
}
