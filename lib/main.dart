import 'package:flutter/material.dart';
import 'package:testing_dummy/Screen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Testing Data Dummy",
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.deepPurple,
      ),
      home: MyLoginPage(),
    );
  }
}
