import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_core/firebase_core/example/lib/firebase_config.dart
import 'package:counterstate/firebase_config.dart';

class CounterStorage {
  bool _initialized = false;

  Future<void> initializeDefault() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseConfig.platformOptions);
    _initialized = true;
  }

  CounterStorage() {
    initializeDefault();
  }

  Future<bool> writeCounter(int counter, int id) async {
    if (!_initialized) {
      await initializeDefault();
    }
    // Access Firestore using the default Firebase app:
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore
        .collection('example')
        .doc('csci567')
        .set({
          'count': counter,
        })
        .then((value) => print("Count Added"))
        .catchError((error) => print("Failed to update count: $error"));

    // await open("mydata.db");
    // CountObject co = CountObject();
    // co.count = counter;
    // co.id = id;
    // await update(co);
    // await close();
    return true;
  }

  Future<int> readCounter(int id) async {
    if (!_initialized) {
      await initializeDefault();
    }
    // Access Firestore using the default Firebase app:
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot value =
        await firestore.collection('example').doc('csci567').get();
    Map<String, dynamic>? data = (value.data()) as Map<String, dynamic>?;
    // print(data['count']);
    return data!['count'];
    // await open("mydata.db");
    // CountObject co = await getCount(id);
    // await close();
    return 0;
  }
}
