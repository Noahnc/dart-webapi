import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'api_router.dart';

/// Similar with the previous example but here we create the routing in our new class 'Service' and we call its handler.
void main() async {
  final service = Service();

  final server = await shelf_io.serve(service.handler, 'localhost', 8080);

  print('Serving at http://${server.address.host}:${server.port}');
}
