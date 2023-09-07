import 'package:authentication/screens/home_screen.dart';
import 'package:flutter/material.dart';
// package imports
import 'package:authentication/screens/splash_screen.dart';
import 'package:authentication/screens/auth_screen.dart';
// firebase imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:authentication/firebase_options.dart';

ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.orange.shade600);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(colorScheme: scheme),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            if (snapshot.hasData) {
              return const HomeScreen();
            }

            return const AuthScreen();
          }),
    ),
  );
}
