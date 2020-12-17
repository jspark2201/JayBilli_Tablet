import 'package:flutter/material.dart';

class SelectTwoPeopleActivity extends StatefulWidget {
  @override
  _SelectTwoPeopleActivityState createState() => _SelectTwoPeopleActivityState();
}

class _SelectTwoPeopleActivityState extends State<SelectTwoPeopleActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('2명 선택했을 때'),
      ),
    );
  }
}
