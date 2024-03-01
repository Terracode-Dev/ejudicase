import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Util/dbManager.dart';
import 'dart:ffi';
import 'Screens/profile.dart';
import 'Screens/login.dart';
//import 'Screens/RegisterScreen.dart';
import 'Util/resources.dart';

void main() async  {

  //DB tools initializing
  await fbAdmin.initializeFirebase();
  Map <int, Map<dynamic, dynamic>> resultSheet = await fbAdmin.retrieveAllData("users") as Map<int, Map<dynamic, dynamic>>;
  //--------------------------------
  // print(resultSheet[1]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login UI',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        // Define the default font family.
        fontFamily: 'Font_1', // Replace with your custom font by adding it to the pubspec.yaml
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: Icon(Icons.menu), // Hamburger menu icon
        actions: [
          Icon(Icons.settings), // Settings or action icon
        ],
      ),
      body: SingleChildScrollView( // Allows for scrolling if content doesn't fit
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home),
                  Icon(Icons.date_range),
                  Icon(Icons.person),
                  Icon(Icons.notifications),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("hell",
                style : TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),),

            // Placeholder for appointments list
            ...List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child : Container(
                    alignment: Alignment.center,
                    child : Container(
                    child : ListTile(
                    leading: Icon(Icons.circle),
                    title: Text('Appointment ${index + 1}'),
                    subtitle: Text('Subtitle text here'),
            ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Customize border color and width here
                    borderRadius: BorderRadius.circular(8), // Optional: if you want rounded corners
                )

            )))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recently', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

    ElevatedButton(
            onPressed: () {
              print(_usernameController.text);// Add Login Functionality
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text('Login', style: TextStyle(color: ColourStack["text_1"])),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.indigo),
            )),

            // Placeholder for recently section
            ...List.generate(3, (index) => ListTile(
              leading: Icon(Icons.circle),
              title: Text('Recent Item ${index + 1}'),
              subtitle: Text('Subtitle text here'),
            ),


            ),
          ],
        ),
      ),





      //---------------ORIGINAL-----------------

      //   appBar: AppBar(
      //   title: Text("E JUDICASE" ,  textAlign: TextAlign.center,
      //     style: TextStyle( color: ColourStack["primary"],fontSize: 24, fontWeight: FontWeight.w900),)
      //   ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Text("this is a sample text"),
      //       ElevatedButton(
      //         onPressed: () {
      //           print(_usernameController.text);// Add Login Functionality
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => Profile()),
      //           );
      //         },
      //         child: Text('Login', style: TextStyle(color: ColourStack["text_1"])),
      //         style: ButtonStyle(
      //           backgroundColor: MaterialStateProperty.all(Colors.indigo),
      //         ),
      //       )
      //     ],
      //   ),
      // )
    );
  }
}








