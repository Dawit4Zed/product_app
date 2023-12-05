import 'package:flutter/material.dart';
import 'package:product_app/homepage.dart';

void main() {
  runApp(MyApp()); // Run the Flutter application by executing the MyApp widget.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEF)),
      home:
          MyHomePage(), // Set the MyHomePage widget as the home screen of the app.
    );
  }
}
