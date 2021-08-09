import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import 'package:notes/screens/add_note_page.dart';

import 'note_info_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var title = "Home";

  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          /*
          REMOVE SHADOW IN APPBAR
          */
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              print('menu');
            },
            icon: Icon(Icons.menu),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                color: Colors.black,
                onPressed: () {
                  print('theme');
                },
                icon: Icon(Icons.invert_colors)),
          ],
        ),
        body: Center(child: buildPages()),
        floatingActionButton: buildFloatingActionButton(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          /*
          REMOVE SHADOW IN BNB
          */
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.class_),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Daily',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: 'Timeline',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
          ],
          onTap: (int index) => onNavBarTap(index),
        ),
      );

  void onNavBarTap(int index) {
    setState(() {
      this.index = index;
      title = listOfPages[index];
    });
  }

  Widget buildFloatingActionButton() => FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          // print('Floating button pressed');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNote()));
        },
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return homePage();
      case 1:
        return daily();
      case 2:
        return timeline();
      case 3:
        return explore();
      default:
        return Container();
    }
  }

  Widget homePage() => Column(
        children: <Widget>[
          buildSearchContainer(),
          Expanded(child: homeListView())
        ],
      );

  Widget buildSearchContainer() => Container(
        height: 65,
        color: Colors.white,
        child: Center(
          child: Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              height: 60,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.search)),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Search',
                            contentPadding: EdgeInsets.only(left: 10),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      );

  Widget homeListView() => ListView.builder(
      itemCount: listOfElements.length,
      itemBuilder: (_, int index) {
        return Container(
          child: ListTile(
              contentPadding: EdgeInsets.all(5),
              leading: CircleAvatar(
                  radius: 30,
                  child: Icon(
                    listOfIcons[index],
                    size: 30,
                  )),
              title: Text(listOfElements[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              subtitle: Text(listOfDescriptions[index]),
              onTap: () {
                // print('ListView element $index');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NoteInfo(
                          title: listOfElements[index],
                          description: listOfDescriptions[index],
                        )));
              }),
        );
      });

  Widget daily() => Container();

  Widget timeline() => Container();

  Widget explore() => Container();
}
