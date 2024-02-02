import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:provider/provider.dart';
import './firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Session.dart';

Future<void> main() async {
  DefaultFirebaseOptions fb = DefaultFirebaseOptions();
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await fb.initializeFirebase();
    runApp(
      ChangeNotifierProvider(
        create: (context) => UserService(),
        child: MyApp(),
      ),
    );
  } catch (e) {
    print("Error initiating Firebase");
  }
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
//