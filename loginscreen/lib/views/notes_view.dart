import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser?.displayName;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
      ),
      body: Column(
        children: [ 
          Text('Welcome ' + user!),
          TextButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/login/');
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}