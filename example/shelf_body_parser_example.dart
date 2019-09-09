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
  print(request.context);
  return Response.ok('[]');
}