import 'package:flutter/material.dart';
import 'package:authentication/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:authentication/firebase_options.dart';

ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.orange.shade600);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      home: const AuthScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(colorScheme: scheme),
    ),
  );
}
