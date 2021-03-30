import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_body_parser/shelf_body_parser.dart';

// Run shelf server and host a [Service] instance on port 8080.
void main() async {
  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(bodyParser(storeOriginalBuffer: false))
      .addHandler(_messages);
  final server = await shelf_io.serve(handler, 'localhost', 9090);
  print('Server running on localhost:${server.port}');
}

Future<Response> _messages(Request request) async {
  // View body data (requires storeOriginalBuffer:true)
  print((request.context['originalBuffer'] as Buffer).store);
  // Read GET parameters
  print((request.context['query'] as Map<String, String>)['aaa']);
  // Read POST parameters (application/x-www-form-urlencoded)
  print((request.context['postParams'] as Map<String, dynamic>)['xx']);
  // Obtain POST binary stream (form-data)
  final file = File('./ccc.png');
  IOSink fileSink = file.openWrite();
  await (request.context['postFileParams']
          as Map<String, List<dynamic>>)['zzz1']![0]
      .part
      .pipe(fileSink);
  await fileSink.close();
  print(((request.context['postFileParams'] as Map<String, dynamic>)['yyy']
      as List<String>)[0]);

  print(request.context);
  return Response.ok('[]');
}
