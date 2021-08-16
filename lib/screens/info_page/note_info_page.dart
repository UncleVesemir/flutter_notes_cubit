import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes/main.dart';

import '../models/note_model.dart';

List<_NoteTile> selectedNotes = [];

class NoteInfo extends StatefulWidget {
  final String title;
  final List<Note> listView;

  NoteInfo({required this.title, required this.listView});

  @override
  _NoteInfo createState() => _NoteInfo();
}

class _NoteInfo extends State<NoteInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: buildParam(),
    );
  }

  Widget buildParam() {
    if (widget.listView[0].description == null) {
      return noListView();
    } else {
      return withListView();
    }
  }

  Widget noListView() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildNote(),
            buildBottomContainer(),
          ],
        ),
      ),
    );
  }

  Widget withListView() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildListView(),
            buildBottomContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildNote() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 250,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.yellowAccent,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(
              'This is the page where you can track everything about ${widget.title}!',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 20,
            ),
            Text(
              'Add your first event to "${widget.title}" '
              'page by entering some text in the text box'
              'below and hitting the send button. Long tap'
              'the send button to align the event in the '
              'opposite direction. Tap on the bookmark icon'
              'on the top right corner to show the bookmarked '
              'events only',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildListView() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
            reverse: true,
            itemCount: notes[0].note?.length,
            itemBuilder: (context, index) {
              return NoteTile(
                description: notes[0].note?[index].description ?? 'empty',
                time: notes[0].note?[index].time ?? 0,
                isSelected: true,
              );
            }),
      ),
    );
  }

  Align buildBottomContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 55,
        ),
        child: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: const Icon(Icons.event),
              ),
              Flexible(
                child: Container(
                  color: Colors.white,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      decoration: const InputDecoration(
                        // border: InputBorder.none,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Enter event',
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (text) {
                        if (text != '') {}
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: const Icon(Icons.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteTile extends StatefulWidget {
  final String description;
  final int time;
  final bool isSelected;

  NoteTile(
      {required this.time,
      required this.description,
      required this.isSelected,
      Key? key})
      : super(key: key);

  @override
  _NoteTile createState() => _NoteTile();
}

class _NoteTile extends State<NoteTile> {
  late bool isSelected;
  late String description;

  @override
  void initState() {
    super.initState();
    description = widget.description;
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? Colors.green[100] : Colors.transparent,
      child: ListTile(
        onLongPress: () {
          setState(() {
            if (isSelected == true) {
              isSelected = false;
              selectedNotes.remove(this);
            } else {
              isSelected = true;
              selectedNotes.add(this);
            }
            print(selectedNotes);
          });
        },
        leading: const Icon(Icons.sports),
        title: Text(widget.description),
        subtitle: Text(widget.time.toString()),
        trailing: selectedNotes.contains(this)
            ? const Icon(
                Icons.check,
                color: Colors.green,
              )
            : null,
      ),
    );
  }
}
