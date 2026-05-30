import 'package:flutter/material.dart';

class InstitutionsPage extends StatelessWidget {
  const InstitutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Institutions"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("Institution ${index + 1}"),
              subtitle: const Text("Institution Details"),
            ),
          );
        },
      ),
    );
  }
}