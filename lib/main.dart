import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

import 'WelcomeScreen.dart';

// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARCart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 32, 26, 12)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
