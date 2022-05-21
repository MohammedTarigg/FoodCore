import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodcore/auth/welcomepageauth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      //darkTheme: ThemeData.dark(),
      title: 'FoodCore',
      debugShowCheckedModeBanner: false,
      home: welcomepageauth(),
    );
  }
}
