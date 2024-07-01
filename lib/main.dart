// import the material package
import 'package:flutter/material.dart';

import './screens/home_screen.dart'; // the file we just create


// run the main method
void main() {
  

  runApp(
    const MyApp(),
  );
}

// create the MyApp widget
class MyApp extends StatelessWidget {
  // ignore: use_super_parameters
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // remove the debug banner
      debugShowCheckedModeBanner: false,
      // set a homepage
      home: HomeScreen(), // we will create this in separate file.
    );
  }
}
