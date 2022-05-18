import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main(){
  runApp(SqliteApp());
}

class SqliteApp extends StatefulWidget {
  const SqliteApp({Key? key}) : super(key: key);

  @override
  State<SqliteApp> createState() => _SqliteAppState();
}

class _SqliteAppState extends State<SqliteApp> {
  int _selectedIndex = 0;
  void _onItemTapped(int index){
    // print("index: $index");
    setState((){
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sqlite Crud App"),),
        body: Center(
          child: Text("Selected Item: $_selectedIndex"),
        ),
        bottomNavigationBar:
        // BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.business),label: "Business"),
        //     BottomNavigationBarItem(icon: Icon(Icons.school),label: "School"),
        //     BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "Account"),
        //   ],
        //   currentIndex: _selectedIndex,
        //   onTap: _onItemTapped,
        //   unselectedIconTheme: IconThemeData( size: 30),
        //   showUnselectedLabels: false,
        // ),
        CurvedNavigationBar(
          items: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.business, color: Colors.white,),
                  Text("Business", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.school,color: Colors.white,),
                  Text("School", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.link_sharp,color: Colors.white,),
                  Text("Link", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_circle,color: Colors.white,),
                  Text("Account", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ],
          color: Colors.blueAccent,
          backgroundColor: Colors.white,
          height: 60,
          index: _selectedIndex,
          onTap: _onItemTapped,
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //     print("Oklm");
        //   },
        //   child: Icon(Icons.add_a_photo_outlined),
        // ),
        drawer: Drawer(

        ),
      ),
    );
  }
}
