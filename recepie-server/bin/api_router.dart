import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import '../models/recipe.dart';
import 'db_handler.dart';

/// Class used to set up all the routing for your server
class Service {
  // The handler/middleware that will be used by the server, all the routing for the server will be implemented here.
  Handler get handler {
    final router = Router();

    router.get('/recipe/<id>', (Request request, String id) {
      var data = DBHandler.getInstance().getById(int.parse(id));
      return Response.ok(jsonEncode(data));
    });

    router.delete('/recipe/<id>', (Request request, String id) {
      DBHandler.getInstance().deleteById(int.parse(id));
      return Response.ok("ID $id deleted");
    });

    router.get('/recipe', (Request request) {
      var data = DBHandler.getInstance().getAll();
      return Response.ok(jsonEncode(data));
    });

    router.post('/recipe', (Request request) async {
      final body = await request.readAsString();
      var recipe = Recipe.fromJson(jsonDecode(body));
      DBHandler.getInstance().create(recipe);
      return Response.ok(body);
    });

    // A catch all of the non implemented routing, useful for showing 404 page now found
    // With the server running try to open http://localhost:8080/abc
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Route not found');
    });

    return router;
  }
}
