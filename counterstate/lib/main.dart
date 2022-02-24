import 'dart:async';
import 'package:counterstate/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        storage: CounterStorage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.storage})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final CounterStorage storage;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = -1;

  void getCount() async {
    int counter = await widget.storage.readCounter(1);
    setState(() {
      _counter = counter;
    });
  }

  @override
  void initState() {
    super.initState();
    getCount();
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    if (kDebugMode) {
      print("$_counter");
    }
    widget.storage.writeCounter(_counter, 1);
  }

  _decrementCounter() async {
    setState(() {
      _counter--;
    });
    if (kDebugMode) {
      print("$_counter");
    }
    widget.storage.writeCounter(_counter, 1);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _counter <= 0 ? null : _decrementCounter,
                      icon: Icon(Icons.remove,
                          color: _counter <= 0 ? Colors.grey : Colors.red),
                    ),
                    _counter == -1
                        ? CircularProgressIndicator()
                        : Column(
                            children: [
                              Text('Like Count:'),
                              Text('$_counter'),
                            ],
                          ),
                    IconButton(
                      onPressed: _counter >= 10 ? null : _incrementCounter,
                      icon: Icon(Icons.plus_one,
                          color: _counter < 10 ? Colors.red : Colors.grey),
                    )
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counter >= 10 ? null : _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
