import 'package:flutter/material.dart';

void main() => runApp( Search());

class Search extends StatelessWidget {

  static const appTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: SearchAppBar(title: appTitle),
    );
  }
}

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key, required this.title});
  final String title;
  @override
  State<SearchAppBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SearchAppBar> {
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
                  Icons.account_circle_outlined,
                  color: Colors.white,)
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              }),
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
            Text('Result',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            SearchResults(),
          ],
        ),
      ),
    );
  }
}

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
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
              "Hi hello",
              style: const TextStyle(fontSize: 16.0,color: Colors.white),
            ),
          ),
          Icon(Icons.favorite),

        ],
      ),
    );
  }
}
