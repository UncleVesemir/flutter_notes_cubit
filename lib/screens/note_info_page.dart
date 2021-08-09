import 'package:flutter/material.dart';

class NoteInfo extends StatelessWidget {
  final String title;
  final String description;

  NoteInfo({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
            child: Text(description, style: const TextStyle(fontSize: 18))));
  }
}
