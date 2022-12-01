import 'package:flutter/material.dart';
import '../presentation_layer/screens/add_note.dart';
import '../presentation_layer/screens/edit_or_delete_note.dart';
import '../presentation_layer/screens/home.dart';

class Routes {
  static const String home = "/";
  static const String addNote = "/addNote";
}

class AppRouter {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Home());
      case Routes.addNote:
        return MaterialPageRoute(builder: (_) => AddNote());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text(
            'No Route Found',
          ),
        ),
      ),
    );
  }
}
