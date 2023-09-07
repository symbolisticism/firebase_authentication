import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseFirestore = FirebaseFirestore.instance;

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // PROPERTIES
  // form key for form validation
  final _formKey = GlobalKey<FormState>();
  // text editing controllers
  final _username = TextEditingController();
  final _password = TextEditingController();
  // variables to hold final values of text inputs
  String _enteredUsername = '';
  String _enteredPassword = '';
  // boolean to switch between sign up and log in modes
  bool _isLogin = true;
  bool _isAuthenticating = false;

  // METHODS
  void submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    _formKey.currentState!.save();
    try {
      if (_isLogin) {
        final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
            email: _enteredUsername, password: _enteredPassword);
        print(userCredentials);
      } else {
        final userCredentials =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: _enteredUsername, password: _enteredPassword);
        print(userCredentials);
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            controller: _username,
            decoration: const InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a valid username';
              }
              return null;
            },
            onSaved: (value) {
              _enteredUsername = value!; // already checked for null
            },
          ),
          const SizedBox(height: 24),
          // password input
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
            onSaved: (value) {
              _enteredPassword = value!; // already checked for null
            },
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              if (!_isAuthenticating)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submit();
                        }
                      },
                      child: Text(_isLogin ? 'Log In' : 'Sign Up'),
                    ),
                  ],
                ),
              const SizedBox(height: 36),
              // button to switch to sign up mode
              if (!_isAuthenticating)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isLogin
                        ? 'Don\'t have an account?'
                        : 'Already have an account?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin ? 'Sign Up' : 'Log In'),
                    ),
                  ],
                ),
              if (_isAuthenticating) const CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
