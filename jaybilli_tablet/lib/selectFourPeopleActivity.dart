import 'package:flutter/material.dart';

class SelectFourPeopleActivity extends StatefulWidget {
  @override
  _SelectFourPeopleActivityState createState() => _SelectFourPeopleActivityState();
}

class _SelectFourPeopleActivityState extends State<SelectFourPeopleActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('4명 선택했을 때'),
      ),
    );
  }
}
