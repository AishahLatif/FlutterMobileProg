import 'dart:async';
import 'package:flutter/material.dart';
import 'package:slumshop/views/loginscreen.dart';
//import 'package:slumshop/views/mainscreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SlumShop',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.anaheimTextTheme(
          Theme.of(context).textTheme.apply(),
        )
      ),
      home: const MySplashScreen(title: 'SlumShop'),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({ Key? key, required String title }) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),()=>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (content) => const LoginScreen()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:AssetImage('assets/images/splash.png'),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Slumshop", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color:Colors.white)),
                CircularProgressIndicator(),
                Text("Version 0.1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }
}

