import 'package:flutter/material.dart';
import 'package:mytutor/models/admin.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required Admin admin}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTUTOR'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Aishah Latif"),
              accountEmail: Text("aishahlatif@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/mytuto.png'),
              ),
            ),
            _createDrawerItem(
              icon: Icons.person,
              text: 'My Profile',
              onTap: () {},
            ),
             _createDrawerItem(
              icon: Icons.info,
              text: 'Tutor available',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.newspaper,
              text: 'News',
              onTap: () {},
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('No Tutor Data'),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}