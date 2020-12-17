import 'package:flutter/material.dart';

class SelectThreePeopleActivity extends StatefulWidget {
  @override
  _SelectThreePeopleActivityState createState() => _SelectThreePeopleActivityState();
}

class _SelectThreePeopleActivityState extends State<SelectThreePeopleActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('3명 선택했을 때'),
      ),
    );
  }
}
