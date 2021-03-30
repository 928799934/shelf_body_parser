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
  // View body data (need to open storeOriginalBuffer)
  print((request.context['originalBuffer'] as Buffer).store);
  // Read GET parameters
  print((request.context['query'] as Map<String, String>)['aaa']);
  // Read POST parameters (application/x-www-form-urlencoded)
  print((request.context['postParams'] as Map<String, dynamic>)['xx']);
  // Obtain POST binary stream (form-data)
  final file = new File('./ccc.png');
  IOSink fileSink = file.openWrite();
  await (request.context['postFileParams'] as Map<String, List<FileParams>>)['zzz1'][0].part.pipe(fileSink);
  fileSink.close();
  print(((request.context['postFileParams'] as Map<String, dynamic>)['yyy'] as List<String>)[0]);

  print(request.context);
  return Response.ok('[]');
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
