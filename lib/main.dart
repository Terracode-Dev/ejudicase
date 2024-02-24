import 'package:flutter/material.dart';
//import 'Util/dbManager.dart';
import 'Screens/profile.dart';
import 'Util/resources.dart';

void main() {

  // //FIrebase Initalization TODO: uncomment follwing
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();



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
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ImageStack["lawLogoHome"] ?? SizedBox(),

              Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Add Forgot Password Functionality
                },
                child: Text('Forgot Password?'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_usernameController.text);// Add Login Functionality
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
                child: Text('Login', style: TextStyle(color: ColourStack["text_1"])),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add Register Functionality
                },
                child: Text('Don\'t have an account? Register'),
              ),
              SizedBox(height: 20),
              Text(
                'version 0.1',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
