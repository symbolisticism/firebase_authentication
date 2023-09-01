import 'package:flutter/material.dart';
import 'package:authentication/screens/auth_screen.dart';

ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.orange.shade600);

void main() {
  runApp(
    MaterialApp(
      home: const AuthScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(colorScheme: scheme),
    ),
  );
}
