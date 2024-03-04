import 'package:flutter/material.dart';
import '../Util/dbManager.dart';
import 'profile.dart';
import '../Util/resources.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}


class _loginpageState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  bool _invalidEntriesVisibility = false;
  void changeInvalidEntryVisibility () {
    setState(() {
      _invalidEntriesVisibility = !_invalidEntriesVisibility;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Login"),
        ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_invalidEntriesVisibility) Container(

                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8), // Optional: if you want rounded corners
                ),
                child : Text('Invalid email or password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.deepOrange),

              ),),
              ImageStack["lawLogoHome"] ?? SizedBox(),
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: _passwordController,
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
                onPressed: () async {
                  int authStatus = await authAdmin.signInUser(emailAddr: _emailController.text , Passwd: _passwordController.text);
                  if (authStatus == 1) {
                    print("user AUthenticated");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  } else if (authStatus == 0) {
                    changeInvalidEntryVisibility();
                  }
                },
                child: Text('Login', style: TextStyle(color: ColourStack["text_1"])),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
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