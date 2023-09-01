import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
          // button to send user info to backend, verify, and log in
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logged In!'),
                      ),
                    );
                  }
                },
                child: _isSigningIn ? const Text('Log In') : const Text('Sign Up'),
              ),
            ],
          ),
          const SizedBox(height: 36),
          // button to switch to sign up mode
          if (_isSigningIn)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSigningIn = false;
                    });
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          // button to switch to sign in mode
          if (!_isSigningIn)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSigningIn = true;
                    });
                  },
                  child: const Text('Log In'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
