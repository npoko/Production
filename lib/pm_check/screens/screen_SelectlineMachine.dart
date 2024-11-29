import 'package:flutter/material.dart';

class SelectMachine extends StatelessWidget {
  const SelectMachine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Machine'),
      ),
      body: Center(
        child: Text('Select Machine Screen'),
      ),
    );
  }
}
