import 'package:flutter/material.dart';
import 'package:nav_stack/test_widgets/test.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Text('Page 2'),
          TestWidget(
            first_name: "Bryan",
            last_name: "Dixon",
          )
        ]),
      ),
    );
  }
}
