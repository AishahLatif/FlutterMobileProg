import 'package:flutter/material.dart';

void main() => runApp( MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
      String name = "Aishah";
    TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    title: "Hello world",
    home: Scaffold(
      appBar: AppBar(title: const Text("Hello World")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter your name: "),
            TextField(
              controller: textEditingController,
            ),
            ElevatedButton(
              onPressed: _pressMe,
              child: const Text("Press Me"),
            ),
            Text(name)
          ],
        ),
      )
     ) );
  }

  void _pressMe() {
    setState(() {
      name = textEditingController.text;
    });
  }
}