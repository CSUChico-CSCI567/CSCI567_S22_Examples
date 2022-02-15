import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

const String tableCount = 'mycount';
const String columnId = '_id';
const String columnCount = 'count';

class CountObject {
  late int id;
  late int count;

  CountObject() {
    // TODO: implement
    // throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnCount: count,
      columnId: id,
    };
    return map;
  }

  CountObject.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    count = map[columnCount];
  }
}

class CounterStorage {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
            create table $tableCount (
              $columnId integer primary key autoincrement,
              $columnCount integer not null)
            ''');
    });
  }

  Future<CountObject> getCount(int id) async {
    List<Map> maps = await db.query(tableCount,
        columns: [columnId, columnCount],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return CountObject.fromMap(maps.first);
    }
    CountObject co = CountObject();
    co.count = 0;
    co.id = id;
    co = await insert(co);
    return co;
  }

  Future<CountObject> insert(CountObject countInstance) async {
    countInstance.id = await db.insert(tableCount, countInstance.toMap());
    return countInstance;
  }

  Future<int> update(CountObject countInstance) async {
    return await db.update(tableCount, countInstance.toMap(),
        where: '$columnId = ?', whereArgs: [countInstance.id]);
  }

  Future close() async => db.close();

  Future<bool> writeCounter(int counter, int id) async {
    await open("mydata.db");
    CountObject co = CountObject();
    co.count = counter;
    co.id = id;
    await update(co);
    await close();
    return true;
  }

  Future<int> readCounter(int id) async {
    await open("mydata.db");
    CountObject co = await getCount(id);
    await close();
    return co.count;
  }
}
