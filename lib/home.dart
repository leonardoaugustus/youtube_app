import 'package:flutter/material.dart';
import 'package:youtube_app/customSearchDelegate.dart';
import 'package:youtube_app/screen/home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _indexBottom = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(_resultado),
      const Text("Whatshot"),
      const Text("Subscriptions"),
      const Text("Folder"),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/youtube.png",
          width: 100,
          height: 25,
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("video Cam");
              },
              icon: const Icon(Icons.videocam)),
          IconButton(
              onPressed: () async {
                String? result = await showSearch(
                    context: context, delegate: CustomSearchDelegate());

                setState(() {
                  _resultado = result.toString();
                });
                print("Resultado digitado " + result.toString());
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                print("Account");
              },
              icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: screens[_indexBottom],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexBottom,
        onTap: (index) {
          setState(() {
            _indexBottom = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: 'Whatshot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Folder',
          ),
        ],
      ),
    );
  }
}
