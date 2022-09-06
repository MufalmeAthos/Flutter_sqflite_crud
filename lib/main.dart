import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqlitecrud/modal.dart';





void main(){
  WidgetsFlutterBinding.ensureInitialized();
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
  int?   _selectedTaskId ;
  String _modalTitle = "New Task";
  BuildContext? context_ ;
  void _onItemTapped(int index){
    // print("index: $index");
    if(index==3){
      Navigator.push(context_!, MaterialPageRoute(builder: (context){ return  const MyStatelessWidget();} ));
    }
    setState((){
      _selectedIndex = index;
    });
  }
  TextEditingController _textController = new TextEditingController();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context_ = context;
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(title: Text("Sqlite Crud App"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Center(
              child: Text("Selected Item: $_selectedIndex"),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                InkWell(
                  onTap: (){
                    _textController.clear();
                    _selectedTaskId = null;
                    _modalTitle = "New Task";
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
                    _persistentSheet(context);
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Persistent Bottom Sheet"),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Text("Tasks of the day", style: TextStyle(color: Colors.blueAccent,fontSize: 14), ),
            Text("(Click the 'Modal Sheet button' to add a task)", style: TextStyle(fontSize: 12),),


            /** The List items now **/
            Center(
              child: FutureBuilder<List<TaskList>>(
                future: DatabaseHelper.instance.getTasks(),
                builder: (BuildContext context, AsyncSnapshot<List<TaskList>> snapshot){

                  // print(snapshot.data);
                  if(!snapshot.hasData){
                    return Center(child: Text("Loading..."),);
                  }
                  return snapshot.data!.isEmpty
                    ?Center(child: Text("No data yet!"),)
                    :Column(
                    children: snapshot.data!.map((taskList) {
                      return Center(
                        child: Card(
                          color: _selectedTaskId != taskList.id || _selectedTaskId == null
                          ? Colors.white
                          : Colors.white70,
                          child: ListTile(
                            title: Text("- "+taskList.name),
                            onTap: (){
                              print(_selectedTaskId);
                              setState((){
                                if(_selectedTaskId == null){
                                  _textController.text = taskList.name;
                                  _selectedTaskId = taskList.id;
                                  _modalTitle = "Edit Task";
                                  _modalSheet(context);
                                }else{
                                  _textController.text = '';
                                  _selectedTaskId = null;
                                  _modalTitle = "New Task";

                                }
                              });
                            },
                            onLongPress: (){
                              setState((){
                                DatabaseHelper.instance.remove(taskList.id!);
                              });
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },

              ),
            )

          ],
        ),
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
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)
          ),
        ),
        context: context,
        builder: (context) {
          // print(_selectedTaskId);
          return Container(
            // height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_drop_down),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_modalTitle),
                    TextField(
                      decoration: InputDecoration(
                        label: Text("Enter a task"),
                        icon: Icon(Icons.text_fields),
                      ),
                      controller: _textController,

                    ),
                    ElevatedButton(
                      onPressed: () async{
                        (_selectedTaskId != null )
                        ? await DatabaseHelper.instance.update(
                           TaskList(id: _selectedTaskId, name: _textController.text),
                        )
                        : await DatabaseHelper.instance.add(
                          TaskList(name: _textController.text),
                        );
                        print(_textController.text);
                        _textController.clear();
                        Timer(
                          Duration(milliseconds: 500),
                          () {
                            _textController.clear();
                            _selectedTaskId = null;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){ return MyHomePage();}
                            ));
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
                      _textController.clear();
                      _selectedTaskId = null;
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

  Widget? _persistentSheet(BuildContext context){
    _scafoldKey.currentState!.showBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(60)
        ),
      ),
      (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close_sharp),
              ),
              Text(
                'With this one, we can still use the context elements and so on '
              ),
              SizedBox(height: 50,),
            ],
          ),
        );
      },
    );

    print(context);

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


class TaskList{
  final int? id;
  final String name;
  TaskList({this.id, required this.name});
  factory  TaskList.fromMap(Map<String, dynamic> json) =>  TaskList(
      id: json['id'],
      name: json['name']
  );

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
    };
  }

}

class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tasklist.db');
    // print("object");
    // print(path);
    // print(join(documentsDirectory.path, 'tasklist.db'));
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE tasks(
    id INTEGER PRIMARY KEY,
    name TEXT
    )
    ''');
  }
  Future<List<TaskList>> getTasks() async{
    Database db = await instance.database;
    // print("object1");
    // print(db);
    var tasks = await db.query('tasks',orderBy: 'id');
    List<TaskList> taskList = tasks.isNotEmpty
    ? tasks.map( (c)=> TaskList.fromMap(c) ).toList()
    : [];
    return taskList;

  }
  Future<int> add(TaskList taskList) async{
    Database db = await instance.database;
    return await db.insert('tasks', taskList.toMap());
  }
  Future<int> remove(int id) async{
    Database db = await instance.database;
    return await db.delete('tasks', where:  'id= ?',whereArgs: [id]);
  }
  Future<int> update(TaskList taskList) async{
    Database db = await instance.database;
    return await db.update('tasks', taskList.toMap(),where: 'id = ?',whereArgs: [taskList.id]);

  }

}



