import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mapp_module/Util/dbManager.dart';
import 'package:mapp_module/Util/resources.dart';
//import 'package:url_launcher/url_launcher.dart';

Map<String, TextEditingController> dataSheet = {
  "Name" : TextEditingController(),
  "email" : TextEditingController(),
  "mob_number" : TextEditingController(),
  "passwd" : TextEditingController(),
  "confirm_passwd" : TextEditingController()
};


class RegisterScreen extends StatefulWidget {
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<RegisterScreen> {

  int currentPageIndex = 0;
  bool _isSwitched = false;


@override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.messenger_sharp),
              ),
              label: 'Messages',
            ),
          ],
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 60), // Adjust the space as needed
              Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ColourStack["primary"]),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 40),
              ),
              SizedBox(height: 30),
              TextField(
                controller: dataSheet["Name"],
                decoration: InputDecoration(
                  labelText: 'Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: dataSheet["email"],
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15),
              TextField(
                controller: dataSheet["mob_number"],
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  prefixIcon: Icon(Icons.phone_android),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 15),
              TextField(
                controller: dataSheet["passwd"],
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: dataSheet["confirm_passwd"],
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('Lawyer  ', style : TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                  Switch(
                    value: _isSwitched,
                    onChanged: (value) {
                      setState(() {
                        _isSwitched = value;
                      });
                    },
                  )
                ],
              ),
              if (_isSwitched) Column(
                children: [
                  TextField(
                    controller: dataSheet["confirm_passwd"],
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Lawyer Firm',
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: dataSheet["confirm_passwd"],
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Law Certificate Ref',
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      value : true;
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I agree with the terms and conditions',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  //TODO : Add 2 controllers and prepare the DataSheet
                  if (_isSwitched) {
                    authAdmin.createUser(type: "Lawyers", emailAddress: emailController.text, password: passwordController.text, dataSheet: dataSheet)
                  } else {
                    authAdmin.createUser(type: "users", emailAddress: emailController.text, password: passwordController.text, dataSheet: dataSheet)
                  }
                },
                child: Text('Next'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Need help? '),
                        // TextSpan(
                        //   text: 'Visit our help center',
                        //   style: TextStyle(color: Colors.blue),
                        //   recognizer: TapGestureRecognizer()
                        //     ..onTap = () {
                        //       // Implement navigation to help center
                        //       launch('https://yourhelpcenterurl.com');
                        //     },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: RegisterScreen()));
