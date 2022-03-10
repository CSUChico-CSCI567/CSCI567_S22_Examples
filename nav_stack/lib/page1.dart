import 'package:flutter/material.dart';
import 'package:nav_stack/page2.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  Widget testWidget(fn, ln) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(fn), Text(ln)],
    );
  }

  Widget PushButton(context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(_createRoute());
      },
      child: const Text('Go!'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          true ? PushButton(context) : testWidget("bob", "bob"),
        ]),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
