import 'package:flutter/material.dart';
import '../main.dart';
import 'add_note_page.dart';

import 'note_info_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String title = 'Home';

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
            icon: const Icon(Icons.menu),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                color: Colors.black,
                onPressed: () {
                  print('theme');
                },
                icon: const Icon(Icons.invert_colors)),
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
            const BottomNavigationBarItem(
              icon: Icon(Icons.class_),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Daily',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: 'Timeline',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
          ],
          onTap: onNavBarTap,
        ),
      );

  void onNavBarTap(int index) {
    setState(() {
      this.index = index;
      title = listOfPages[index];
    });
  }

  Widget buildFloatingActionButton() => FloatingActionButton(
        child: const Icon(
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
              margin: const EdgeInsets.all(10),
              height: 60,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: const Icon(Icons.search)),
                      const Expanded(
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
                  ),
              ),
            ),
          ),
        ),
      );

  Widget homeListView() => ListView.builder(
      itemCount: listOfElements.length,
      itemBuilder: (_, index) {
        return ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: CircleAvatar(
                  radius: 30,
                  child: Icon(
                    listOfIcons[index],
                    size: 30,
                  )),
              title: Text(listOfElements[index],
                  style: const TextStyle(
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
              },
        );
      });

  Widget daily() => Container();

  Widget timeline() => Container();

  Widget explore() => Container();
}
