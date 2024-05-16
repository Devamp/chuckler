import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:chuckler/pages/feed_page.dart';
import 'package:provider/provider.dart';
import './firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Session.dart';
import 'database/isarDB.dart';

Future<void> main() async {
  DefaultFirebaseOptions fb = DefaultFirebaseOptions();
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.openDB();

  try {
    await fb.initializeFirebase();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserService()),
        Provider<IsarService>(create: (context) => IsarService()),
      ],
      child: MyApp(),
    ));
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
      theme: ThemeData(primarySwatch: Colors.amber),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
//