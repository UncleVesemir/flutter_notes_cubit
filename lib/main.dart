import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

List<String> listOfElements = ['Weekend', 'Sleep', 'Sport'];
List<String> listOfDescriptions = [
  'travel to NY',
  '6:00 wake up',
  '7:00 stadium run'
];
List<String> listOfPages = ['Home', 'Daily', 'Timeline', 'Explore'];
List<String> listOfActivities = ['Travel', 'Sport', 'Food', 'Sleep'];
List<IconData> listOfIcons = [
  Icons.flight_takeoff,
  Icons.hotel,
  Icons.sports,
  Icons.sports,
  Icons.sports,
  Icons.sports,
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.black,
    home: MainPage(),
  );
}


