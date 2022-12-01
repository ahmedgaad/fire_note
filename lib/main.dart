import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/dynamic_link_provider.dart';
import 'core/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DynamicLinkProvider().initDynamicLink();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.getRoute,
      initialRoute: Routes.home,
    );
  }
}
