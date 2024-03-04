import 'package:flutter/material.dart';

void main() => runApp( NotificationSection());

class NotificationSection extends StatelessWidget {

  static const appTitle = 'Lawyers';

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
                  Icons.account_circle,
                  color: Colors.white,)
            )
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ImgCard(cardtitle: "Card 1",text: "card 1"),
                          ImgCard(cardtitle: "Card 2",text: "card 2"),
                          ImgCard(cardtitle: "Card 3",text: "card 3"),
                          ImgCard(cardtitle: "Card 4",text: "card 4"),
                          ImgCard(cardtitle: "Card 5", text: "card 5"),
                          ImgCard(cardtitle: "Card 6", text: "card 6"),
                          ImgCard(cardtitle: "Card 7", text: "card 7"),
                        ],
                      ),
                    )
                  ],
                ),
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
        body: Container(
            child:  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 20.0,
                  ),
                  const Text("Online Lawyers",style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
                  Container(
                    height: 20.0,
                  ),
                  ImgCard(cardtitle: "Card 1",text: "card 1"),
                  ImgCard(cardtitle: "Card 2",text: "card 2"),
                  ImgCard(cardtitle: "Card 3",text: "card 3"),
                  ImgCard(cardtitle: "Card 4",text: "card 4"),
                  ImgCard(cardtitle: "Card 5", text: "card 5"),
                  ImgCard(cardtitle: "Card 6", text: "card 6"),
                  ImgCard(cardtitle: "Card 7", text: "card 7"),
                  ImgCard(cardtitle: "Card 1",text: "card 1"),
                  ImgCard(cardtitle: "Card 2",text: "card 2"),
                  ImgCard(cardtitle: "Card 3",text: "card 3"),
                  ImgCard(cardtitle: "Card 4",text: "card 4"),
                  ImgCard(cardtitle: "Card 5", text: "card 5"),
                  ImgCard(cardtitle: "Card 6", text: "card 6"),
                  ImgCard(cardtitle: "Card 7", text: "card 7"),
                ],
              ),
            )
        ),
      ),
    );
  }
}

class ImgCard extends StatelessWidget {
  final String text;
  final String cardtitle;

  const ImgCard({required this.text,required this.cardtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children:[
            const Icon(
              Icons.account_circle,
              size: 50,
              color: Colors.blue,
            ),
            Container(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
