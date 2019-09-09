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
  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Server running on localhost:${server.port}');
}

Future<Response> _messages(Request request) async {
  // 查看 body 数据(需打开 storeOriginalBuffer)
  print((request.context['originalBuffer'] as Buffer).store);
  // 获取 get 参数
  print((request.context['query'] as Map<String, String>)['aaa']);
  // 获取 post 文本参数(application/x-www-form-urlencoded)
  print((request.context['postParams'] as Map<String, dynamic>)['xx']);
  // 获取 post 二进制流(form-data)
  final file = new File('./ccc.png');
  IOSink fileSink = file.openWrite();
  await (request.context['postFileParams'] as Map<String, List<FileParams>>)['zzz1'][0].part.pipe(fileSink);
  fileSink.close();
  print(((request.context['postParams'] as Map<String, dynamic>)['yyy'] as List<String>)[0]);

  print(request.context);
  return Response.ok('[]');
}