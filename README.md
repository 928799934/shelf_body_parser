A Middleware for Shelf.

Created from templates made available by Lijian under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_body_parser/shelf_body_parser.dart';

// Run shelf server and host a [Service] instance on port 8080.
void main() async {
  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(bodyParser(storeOriginalBuffer: false))
      .addHandler(_messages);
  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Server running on localhost:${server.port}');
}

Future<Response> _messages(Request request) async {
  // context['query']
  // context['postParams']
  // context['postFileParams']
  // context['originalBuffer']
  print(request.context);
  return Response.ok('[]');
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
