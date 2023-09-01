import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

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
  final _fullName = TextEditingController();
  // variables to hold final values of text inputs
  String _enteredUsername = '';
  String _enteredPassword = '';
  // boolean to switch between sign up and log in modes
  bool _isSigningIn = true;
  bool _isAuthenticating = false;

  // METHODS
  void submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isSigningIn) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredUsername, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredUsername, password: _enteredPassword);
      }

      
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // full name input
          if (!_isSigningIn)
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              controller: _fullName,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a valid name';
                }
                return null;
              },
              onSaved: (value) {
                _enteredUsername = value!; // already checked for null
              },
            ),
          const SizedBox(height: 24),
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
                      child: Text(_isSigningIn ? 'Log In' : 'Sign Up'),
                    ),
                  ],
                ),
              const SizedBox(height: 36),
              // button to switch to sign up mode
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isSigningIn
                      ? 'Don\'t have an account?'
                      : 'Already have an account?'),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSigningIn = !_isSigningIn;
                      });
                    },
                    child: Text(_isSigningIn ? 'Sign Up' : 'Log In'),
                  ),
                ],
              ),
              if (_isAuthenticating) const CircularProgressIndicator(),
            ],
          ),
          // button to send user info to backend, verify, and log in
        ],
      ),
    );
  }
}
