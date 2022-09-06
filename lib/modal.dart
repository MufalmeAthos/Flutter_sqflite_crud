import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sqlitecrud/main.dart';

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}
class _MyStatelessWidgetState extends State<MyStatelessWidget> {

  int _selectedIndex = 3;
  void _onItemTapped(int index){
    // print("index: $index");

    if(index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context){ return  const MyHomePage();} ));
    }
    setState((){
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sqlite Crud App"),),
      body: Center(
        child: ElevatedButton(
          child: const Text('showModalBottomSheet'),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Modal BottomSheet'),
                        ElevatedButton(
                          child: const Text('Close BottomSheet'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar:
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
}



//I will need to use this draft for my future projects