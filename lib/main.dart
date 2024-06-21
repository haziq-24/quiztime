// import the material package
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';
import './screens/home_screen.dart'; // the file we just create
import './models/db_connect.dart';

// run the main method
void main()  {
   // Wait for data to be fetched

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
