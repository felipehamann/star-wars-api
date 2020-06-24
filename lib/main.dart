import 'package:flutter/material.dart';
import 'package:starwars/src/pages/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1D1E22),
        accentColor: Color(0xFFFFE300),
      ),
      home: HomePage(),
    );
  }
} 



