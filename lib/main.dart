import 'package:authentication/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'authentication-portfolio',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(home: AuthScreen()));
}
