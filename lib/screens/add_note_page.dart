import 'package:flutter/material.dart';
import 'package:notes/main.dart';

import 'home_screen.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNote createState() => _AddNote(Colors.grey);
}

class _AddNote extends State<AddNote> {
  var colorFAB;
  var title;
  var description;

  _AddNote(this.colorFAB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }),
        title: Text(
          'Add note',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              autofocus: true,
              onChanged: (String text) {
                if (text != '') {
                  setState(() {
                    title = text;
                    colorFAB = Colors.green;
                  });
                } else {
                  setState(() {
                    title = text;
                    colorFAB = Colors.grey;
                  });
                }
              },
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title of your note',
                helperText: '*required field, keep it short',
                helperStyle: TextStyle(
                  color: Colors.blue
                ),
                labelText: 'Title',
                contentPadding: EdgeInsets.all(10),
              ),
            )),
        Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              autofocus: false,
              onChanged: (String text) {
                setState(() {
                  if (text != '')
                    description = text;
                  else
                    description = '';
                });
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write something',
                labelText: 'Description',
                contentPadding: EdgeInsets.all(10),
              ),
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        backgroundColor: colorFAB,
        onPressed: () {
          if (colorFAB == Colors.green) {
            setState(() {
              listOfElements.add(title);
              listOfDescriptions.add(description);
            });
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          }
        },
      ),
    );
  }
}
