import 'package:flutter/material.dart';
import 'package:mytutor_new/views/subjects.dart';
import 'package:mytutor_new/views/tutors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _tabs = <Widget>[
    SubjectScreen(),
    TutorScreen(),
    SubjectScreen(),
    SubjectScreen(),
    SubjectScreen()
  ];
  int _currentIndex = 0;
  late double screenHeight, screenWidth, resWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      body: Center(
        child: _tabs.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(    
        unselectedIconTheme: const IconThemeData(
          color: Colors.deepOrangeAccent,
          ),
        unselectedItemColor: Colors.deepOrangeAccent,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedFontSize: 15,
        selectedIconTheme: const IconThemeData(color: Colors.redAccent),
        selectedItemColor: Colors.indigo,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items:  [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
                size: resWidth * 0.07,
              ),
              label: "Subject"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded
              , size: resWidth * 0.07
              ),
              label: "Tutors"),
          BottomNavigationBarItem(
              icon: Icon(Icons.alarm_add_rounded
              , size: resWidth * 0.07), 
              label: "Subscribe"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded
              , size: resWidth * 0.07), 
              label: "Favourite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded
              , size: resWidth * 0.07), 
              label: "Profile")
        ],
      ),  
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}