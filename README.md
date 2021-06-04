# request

A minimal abstraction of the 'http' package's 'get' and 'post'
methods that automatically throws an exception when any non-200
status code is returned.

# Usage

```dart
import 'package:request/request.dart' as http;
```

Like `http`, `request` exposes the [get] and [post] methods, which directly
wrap `http`'s equivalent methods, but throw a [HttpStatusException] when any
status other than `200` is returned.

```dart
final response = await http.get(uri);
```

```dart
final reponse = await http.post(uri);
```

Additionally, `request` exposes the [request] method, which wraps [get] and
returns the response's body as a [String]. Like [get] and [post], an exception
will be thrown when any status other than `200` is returned.

```dart
final body = await http.request(uri);
```

## Uri Extension Methods

[get], [post], and [request] are also available as extension methods on
Dart's [Uri] object.

```dart
final url = Uri.parse('https://pub.dev/packages/request');
final body = await url.request();
```

## HttpStatusException

Returned [HttpStatusException]s contain the original [response], and has getters
for the requested [url], [statusCode] and [message].

[message] defaults to [response.reasonPhrase], and if `null`, falls back to the
standard status code phrases as defined by the [W3C](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html).
