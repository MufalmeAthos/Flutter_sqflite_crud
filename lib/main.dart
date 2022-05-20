import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sqlitecrud/modal.dart';

void main(){
  runApp(SqliteApp());
}

class SqliteApp extends StatefulWidget {
  const SqliteApp({Key? key}) : super(key: key);

  @override
  State<SqliteApp> createState() => _SqliteAppState();
}

class _SqliteAppState extends State<SqliteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  void _onItemTapped(int index){
    // print("index: $index");
    if(index==3){
      Navigator.push(context, MaterialPageRoute(builder: (context){ return  const MyStatelessWidget();} ));
    }
    setState((){
      _selectedIndex = index;
    });
  }
   TextEditingController _textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sqlite Crud App"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Selected Item: $_selectedIndex"),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children:  [
              InkWell(
                onTap: (){
                  _modalSheet(context);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Modal Bottom Sheet"),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  print("persistent");
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Persistent Bottom Sheet"),
                  ),
                ),
              )
            ],
          )
        ],
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
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        // tooltip: "oklm",

        onPressed: (){
          print("Oklm");
          _datePicker(context);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context){return MyStatelessWidget();}));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.date_range_outlined),
            // Text(" data"),
          ],
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text("Main Menu"),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push( context,MaterialPageRoute(
                        builder: (context) =>  MyHomePage()
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.business, color: Colors.blueAccent,),
                      SizedBox(width: 15,),
                      Text("Business", style: TextStyle(color: Colors.black),)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.school,color: Colors.blueAccent,),
                    SizedBox(width: 15,),
                    Text("School", style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.link_sharp,color: Colors.blueAccent,),
                    SizedBox(width: 15,),
                    Text("Link", style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> MyStatelessWidget()
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.account_circle,color: Colors.blueAccent,),
                      SizedBox(width: 15,),
                      Text("Account", style: TextStyle(color: Colors.black),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget? _modalSheet(BuildContext context){
    showModalBottomSheet(
      // shape: ShapeBorder(),
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_drop_down),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Enter Task"),
                    TextField(
                      controller: _textController,

                    ),
                    ElevatedButton(
                        onPressed: (){
                          print(_textController.text);
                          _textController.clear();
                          Timer(
                            Duration(milliseconds: 500),
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_alt),
                            Text(" Save")
                          ],
                        ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close_sharp)
                ),
              ],
            ),
          );
        }
 );
  }

  Widget? _datePicker(BuildContext context){
    showDatePicker(
      context: context,
      initialDate: DateTime.now() ,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
    );
  }
}


