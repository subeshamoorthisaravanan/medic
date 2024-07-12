import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medic/database.dart';
import 'package:medic/dialogBox.dart';
import 'package:medic/tile_person.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _box = Hive.box('UsersBox');
  late PersonDataBase db;
  final _controller = TextEditingController();

  void initState() {
    super.initState();
    db = PersonDataBase(); // Initialize PersonDataBase
    if (_box.get("PERSONLIST") == null) {
      db.loadData(); // Call loadData method to initialize data
    } else {
      db.loadData();
    }
  }


  void saveNewPerson() {
    setState(() {
      db.personList.add(_controller.text); // Add person directly
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewPerson() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewPerson,
        );
      },
    );
    db.updateDataBase();
  }

  void deletePerson(int index) {
    setState(() {
      db.personList.removeAt(index);
    });
    db.updateDataBase();
  }

  void editPerson(int index) {
    String currentName = db.personList[index];
    TextEditingController _controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: () {
            setState(() {
              db.personList[index] = _controller.text; // Update person directly
            });
            Navigator.of(context).pop(); // Close the dialog
            db.updateDataBase();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          title: Text('Medic'),
          backgroundColor: Color(0xff43B3AE),
          centerTitle: true,
        ),
        body: db.personList.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Person Found",
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
            : Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "Person List",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: db.personList.length,
                itemBuilder: (context, index) {
                  return TilePerson(
                    personname: db.personList[index],
                    deleteFunction: (context) => deletePerson(index),
                    editFunction: (context) => editPerson(index),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff43B3AE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: createNewPerson,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }
}
