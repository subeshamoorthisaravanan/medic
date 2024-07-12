import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medic/dialogBox.dart';
import 'package:medic/tile_Detail.dart';
import 'package:medic/tile_person.dart';
import 'database.dart';

class PersonDetailsPage extends StatefulWidget {
  final String personName;

  const PersonDetailsPage({Key? key, required this.personName}) : super(key: key);

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  late DetailDataBase db;
  final _box = Hive.box('DetailBox');
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = DetailDataBase(widget.personName); // Initialize DetailDataBase with personName
    db.loadData(); // Load data for the specific personName
    openDetailBox(); // Open the detail box
  }

  void openDetailBox() async {
    await Hive.openBox(widget.personName);
  }


  void saveNewDetail() {
    setState(() {
      db.addDetail(_controller.text); // Add medicine directly
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase(); // Update without passing personName
    addDetailToHive(_controller.text); // Call the method to add detail to Hive
  }

  void addDetailToHive(String medicineName) async {
    var box = await Hive.openBox(widget.personName);
    box.add(medicineName);
  }

  void createNewDetail() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewDetail,
        );
      },
    );
  }

  void deleteDetail(int index) {
    setState(() {
      db.removeDetail(db.detailList[index]); // Remove medicine directly
    });
    db.updateDataBase(); // Update without passing personName
  }

  void editDetail(int index) {
    String currentName = db.detailList[index];
    TextEditingController _controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: () {
            setState(() {
              db.detailList[index] = _controller.text; // Update medicine directly
            });
            Navigator.of(context).pop(); // Close the dialog
            db.updateDataBase(); // Update without passing personName
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text('${widget.personName}'),
        centerTitle: true,
        backgroundColor: Color(0xff43B3AE),
      ),
      body: db.detailList.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No Detail Found",
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
              "Medicine List",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: db.detailList.length,
              itemBuilder: (context, index) {
                return TileDetail(
                  medicinename: db.detailList[index],
                  deleteFunction: (context) => deleteDetail(index),
                  editFunction: (context) => editDetail(index),
                  personName: widget.personName,
                  onSelected: null,
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
        onPressed: createNewDetail,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
