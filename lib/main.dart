import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import './firebase/firebase_options.dart';

Future<void> main() async {
  DefaultFirebaseOptions fb = DefaultFirebaseOptions();
  WidgetsFlutterBinding.ensureInitialized();
  await fb.initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuckler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
