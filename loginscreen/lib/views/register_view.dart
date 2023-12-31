import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Enter your email here",
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Enter your password here",
            ),
          ),
          TextField(
            controller: _username,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: "Enter your username here",
            ),
          ),
          TextButton.icon(
              onPressed: () async {
                final email = _email.text; 
                final password = _password.text;
                final username = _username.text;

                try {
                final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                ).then((userCredential) {
                  userCredential.user?.updateDisplayName(username);
                });
                print(userCredential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print("The password you entered is too weak!");
                  }
                  else if (e.code == 'email-already-in-use') {
                    print("The Email is already in use!");
                  }
                  else if (e.code == 'invalid-email') {
                    print("The Email you entered is invalid!");
                  } 
                }
              },
              icon: const Icon(Icons.app_registration),
              label: const Text('Register'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context, '/login/',
                (route) => false
                );
            },
            icon: const Icon(Icons.login),
            label: const Text('Already have an account? Login here!'),
          ),
        ],
      ),
    );
  }
}