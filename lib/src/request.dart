import 'dart:convert';
import 'package:http/http.dart' as http show get, post;
import 'package:http/http.dart' hide get, post;

export 'package:http/http.dart' hide get, post;

/// Sends an HTTP GET request with the given headers to the given URL.
///
/// {@template request.httpStatusException}
///
/// A [HttpStatusException] will be thrown if any non-200
/// HTTP status code is returned from the request.
///
/// {@endtemplate}
Future<Response> get(Uri url, {Map<String, String>? headers}) async {
  final response = await http.get(url, headers: headers);
  if (response.statusCode != 200) throw HttpStatusException(response);
  return response;
}

/// Returns the body of the requested [uri].
///
/// {@macro request.httpStatusException}
Future<String> request(Uri uri, {Map<String, String>? headers}) async {
  final response = await get(uri, headers: headers);
  return response.body;
}

/// Sends an HTTP POST request with the given headers and body to the given URL.
///
/// [body] sets the body of the request. It can be a [String], a [List] or
/// a [Map<String, String>]. If it's a String, it's encoded using [encoding]
/// and used as the body of the request. The content-type of the request will
/// default to "text/plain".
///
/// If [body] is a List, it's used as a list of bytes for the body of the request.
///
/// If [body] is a Map, it's encoded as form fields using [encoding].
/// The content-type of the request will be set to "application/
/// x-www-form-urlencoded"; this cannot be overridden.
///
/// [encoding] defaults to [utf8].
///
/// {@macro request.httpStatusException}
Future<Response> post(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final response =
      await http.post(url, headers: headers, body: body, encoding: encoding);
  if (response.statusCode != 200) throw HttpStatusException(response);
  return response;
}

/// An exception thrown when a non-OK HTTP status is returned from a request.
class HttpStatusException implements Exception {
  /// Constructs a new exception from the HTTP [response].
  const HttpStatusException(this.response);

  /// The HTTP response associated with this exception.
  final Response response;

  /// The URL associated with this exception.
  String? get url => response.request?.url.toString();

  /// The status code associated with this exception.
  int get statusCode => response.statusCode;

  /// The reason/message associated with the status code.
  String? get message {
    if (response.reasonPhrase != null) return response.reasonPhrase!;

    String? message;

    switch (statusCode) {
      case 100:
        'Continue';
        break;
      case 201:
        'Created';
        break;
      case 202:
        'Accepted';
        break;
      case 203:
        'Non-Authoritative Information';
        break;
      case 204:
        'No Content';
        break;
      case 205:
        'Reset Content';
        break;
      case 206:
        'Partial Content';
        break;
      case 300:
        'Multiple Choices';
        break;
      case 301:
        'Moved Permanently';
        break;
      case 302:
        'Found';
        break;
      case 303:
        'See Other';
        break;
      case 304:
        'Not Modified';
        break;
      case 305:
        'Use Proxy';
        break;
      case 307:
        'Temporary Redirect';
        break;
      case 400:
        'Bad Request';
        break;
      case 401:
        'Unauthorized';
        break;
      case 402:
        'Payment Required';
        break;
      case 403:
        'Forbidden';
        break;
      case 404:
        'Not Found';
        break;
      case 405:
        'Method Not Allowed';
        break;
      case 406:
        'Not Acceptable';
        break;
      case 407:
        'Proxy Authentication Required';
        break;
      case 408:
        'Request Timeout';
        break;
      case 409:
        'Conflict';
        break;
      case 410:
        'Gone';
        break;
      case 411:
        'Length Required';
        break;
      case 412:
        'Precondition Failed';
        break;
      case 413:
        'Request Entity Too Large';
        break;
      case 414:
        'Request-URI Too Long';
        break;
      case 415:
        'Unsupported Media Type';
        break;
      case 416:
        'Requested Range Not Satisfiable';
        break;
      case 417:
        'Expectation Failed';
        break;
      case 500:
        'Internal Server Error';
        break;
      case 501:
        'Not Implemented';
        break;
      case 502:
        'Bad Gateway';
        break;
      case 503:
        'Service Unavailable';
        break;
      case 504:
        'Gateway Timeout';
        break;
      case 505:
        'HTTP Version Not Supported';
        break;
    }

    return message;
  }

  @override
  String toString() =>
      'HTTP request failed with status code: $statusCode ($url)';
}
