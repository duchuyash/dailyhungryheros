import 'package:dailyhungryheros/screens/login.dart';
import 'package:dailyhungryheros/screens/ready.dart';
import 'package:dailyhungryheros/screens/result_dual.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/music.dart';

Future<void> main(List<String> args) async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Music.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'login' : 'ready',
      routes: {
        'login': (context) => Login(),
        'ready': (context) => Ready(),
        'result': (context) => ResultDual(result: 5),
      },
    );
  }
}
