import 'package:flutter/material.dart';
import 'package:mytutor/views/tutors.dart';
//import 'package:mytutor/models/admin.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Buyer";
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    tabchildren = const[
      MainScreen(
        //user: widget.user,
      ),
      Tutors(
        //user: widget.user
      ),
      MainScreen(
        //user: widget.user,
      ),
      MainScreen(),
      MainScreen()
    ];
  }

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
      appBar: AppBar(
        title: const Text('MyTUTOR'),
      ),
      //body: tabchildren[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.arrow_right_rounded
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
      if (_currentIndex == 0) {
        maintitle = "Subject";
      }
      if (_currentIndex == 1) {
        maintitle = "Tutors";
      }
      if (_currentIndex == 2) {
        maintitle = "Subscribe";
      }
      if (_currentIndex == 3) {
        maintitle = "Favourite";
      }
      if (_currentIndex == 4) {
        maintitle = "Profile";
      }
    });
  }
}
