import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytutor_new/views/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My TUTOR',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(),
        ),
      ),
      home: const MySplashScreen(title: 'My TUTOR'), 
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreen();
}

class _MySplashScreen extends State<MySplashScreen> {
late double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      ()=>Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (contents) => const LoginScreen()
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: Image.asset('assets/images/mytuto.png'),
              ),
              const CircularProgressIndicator(),
              const Text("Welcome to MY TUTOR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  } 
}
