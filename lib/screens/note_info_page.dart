import 'package:flutter/material.dart';

class NoteInfo extends StatelessWidget {
  final title;
  final description;

  NoteInfo({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
            child: Text(description, style: TextStyle(fontSize: 18))));
  }
}
