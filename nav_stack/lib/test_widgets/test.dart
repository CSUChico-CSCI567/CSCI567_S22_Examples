import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  String first_name;
  String last_name;

  TestWidget(
      {Key? key,
      required String this.first_name,
      required String this.last_name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(first_name), Text(last_name)],
    );
  }
}
