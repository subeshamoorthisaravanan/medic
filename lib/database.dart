import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PersonDataBase {
  final _box = Hive.box('UsersBox');
  late List<String> personList;

  List<String> get PersonList => _box.get('PERSONLIST', defaultValue: []);

  void addPerson(String personName) {
    List<String> updatedList = [...personList, personName];
    _box.put('PERSONLIST', updatedList);
  }

  void removePerson(String personName) {
    List<String> updatedList = [...personList];
    updatedList.remove(personName);
    _box.put('PERSONLIST', updatedList);
    // Also delete the corresponding detail box
    Hive.deleteBoxFromDisk(personName);
  }
  void loadData() {
    // Load data from Hive box
    var dataList = _box.get("PERSONLIST", defaultValue: []);
    if (dataList != null && dataList is List<String>) {
      personList = dataList;
    } else {
      personList = [];
    }
  }




  void updateDataBase() {
    // Update data in Hive box
    _box.put("PERSONLIST", personList);
  }
}

class DetailDataBase {
  final String personName;
  final Box _box;
  late List<String> DetailList;

  DetailDataBase(this.personName) : _box = Hive.box(personName);

  List<String> get detailList => _box.get('DETAILLIST', defaultValue: []);


  void addDetail(String detail) {
    List<String> updatedList = [...detailList, detail];
    _box.put('DETAILLIST', updatedList);
  }

  void removeDetail(String detail) {
    List<String> updatedList = [...detailList];
    updatedList.remove(detail);
    _box.put('DETAILLIST', updatedList);
  }

  void loadData() {
    // Load data from Hive box
    var dataList = _box.get("DETAILLIST", defaultValue: []);
    if (dataList != null && dataList is List<String>) {
      DetailList = dataList;
    } else {
      DetailList = [];
    }
  }


  void updateDataBase() {
    // Update data in Hive box
    _box.put("DETAILLIST", DetailList);
  }
}

