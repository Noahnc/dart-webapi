import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import '../models/recipe.dart';

/// Class used to set up all the routing for your server
class Service {
  // The handler/middleware that will be used by the server, all the routing for the server will be implemented here.
  Handler get handler {
    final router = Router();

    router.get('/recipe/<id>', (Request request, int id) {
      return Response.ok(id);
    });

    router.delete('/recipe/<id>', (Request request, int id) {
      return Response.ok("Delete id: $id");
    });

    router.get('/recipe', (Request request) {
      return Response.ok("Working");
    });

    router.post('/recipe', (Request request) {
        final body = request.readAsString();
        return Response.ok(body);
    });

    // A catch all of the non implemented routing, useful for showing 404 page now found
    // With the server running try to open http://localhost:8080/abc
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}
