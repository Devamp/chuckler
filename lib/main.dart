import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chuckler/route_generator.dart';
import 'package:provider/provider.dart';
import './firebase/firebase_options.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'Session.dart';
import 'database/isarDB.dart';
import 'Theme/theme.dart';

//TODO MAKE SURE TO LOOK AT EMULATOR COMMIT BEFORE PRODUCTION
//TODO THIS WILL ENSURE THAT EMULATOR CODE IS NOT INCLUDED WITH APP .firebaserc, 2 XMLS in android w/TODOS, Firebase JSON

Future<void> main() async {
  DefaultFirebaseOptions fb = DefaultFirebaseOptions();
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.openDB();

  try {
    await fb.initializeFirebase();

    ///TODO REMOVE NEXT FOUR LINES BEFORE DEPLOYMENT!!!!
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5081);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    ////TODO REMOVE ABOVE BEFORE DEBLOYMENT




    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserService()),
        Provider<IsarService>(create: (context) => IsarService()),
        Provider<FirebaseFirestore>(create: (context) => FirebaseFirestore.instance)
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
      theme: darkThemeData(context),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
