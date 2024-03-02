import 'package:flutter/material.dart';

void main() => runApp( NotificationSection());

class NotificationSection extends StatelessWidget {

  static const appTitle = 'Notification';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Notification(title: appTitle),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({super.key, required this.title});
  final String title;
  @override
  State<Notification> createState() => _Notification();
}

class _Notification extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(onPressed: ()=>{},
                icon: const Icon(
                  Icons.notifications_on,
                  color: Colors.white,)
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.account_circle,
                      color: Colors.white,
                      size: 55.0,
                    ),
                  ),
                  Column(
                    children: [
                      Text("Profile",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      Text("Data",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                  ),
                  child: Text(
                    'ejudicase',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
              ),
              const ListTile(
                title: Text('Title 1'),
              ),
              ListTile(
                title: const Text('Title 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const ListTile(
                title: Text('Title 3'),

              ),
            ],
          ),
        ),
        body: const Column(
          children: [
            NotifiBar(),
          ],
        ),
      ),
    );
  }
}

class NotifiBar extends StatefulWidget {
  const NotifiBar({super.key});

  @override
  State<NotifiBar> createState() => _NotifiBar();
}

class _NotifiBar extends State<NotifiBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.white54),
          color: Colors.indigo
      ),
      child: Row(
        children: [
          // Image placeholder
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(width: 16.0),
          // Title text
          Expanded(
            child: Text(
              "Notification",
              style: const TextStyle(fontSize: 16.0,color: Colors.white),
            ),
          ),
          Icon(Icons.read_more,
            color: Colors.white,
          ),
          Icon(Icons.not_interested_rounded,
            color: Colors.white,
          ),

        ],
      ),
    );
  }
}
