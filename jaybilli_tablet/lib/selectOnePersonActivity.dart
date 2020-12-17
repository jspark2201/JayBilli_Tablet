import 'package:flutter/material.dart';

class SelectOnePersonActivity extends StatefulWidget {
  @override
  _SelectOnePersonActivityState createState() => _SelectOnePersonActivityState();
}

class _SelectOnePersonActivityState extends State<SelectOnePersonActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('1명 선택했을 때'),
      ),
    );
  }
}
