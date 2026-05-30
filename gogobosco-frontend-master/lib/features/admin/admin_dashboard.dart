import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: ListView(
        children: const [
          ListTile(title: Text("Post Announcement")),
          ListTile(title: Text("Add Event")),
          ListTile(title: Text("Post Job")),
        ],
      ),
    );
  }
}
