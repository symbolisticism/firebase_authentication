import 'package:flutter/material.dart';
import 'package:authentication/widgets/sign_in_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Authentication'),
      ),
      body: const Center(
        // used Center here to get the image to center
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SignInForm(),
        ),
      ),
    );
  }
}
