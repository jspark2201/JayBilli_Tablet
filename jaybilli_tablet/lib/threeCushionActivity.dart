import 'package:flutter/material.dart';
import 'package:jaybilli_tablet/selectFourPeopleActivity.dart';
import 'package:jaybilli_tablet/selectOnePersonActivity.dart';
import 'package:jaybilli_tablet/selectThreePeopleActivity.dart';
import 'package:jaybilli_tablet/selectTwoPeopleActivity.dart';

class ThreeCushionActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424543),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.arrow_back_ios_rounded),
              iconSize: 50,
              onPressed: () {
                Navigator.pop(context);
              }),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    height: 300,
                    minWidth: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      color: Color(0xff366796),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectOnePersonActivity()));
                      },
                      child: Text(
                        '1명',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  ButtonTheme(
                    height: 300,
                    minWidth: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      color: Color(0xff366796),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectTwoPeopleActivity()));
                      },
                      child: Text(
                        '2명',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    height: 300,
                    minWidth: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      color: Color(0xff366796),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectThreePeopleActivity()));
                      },
                      child: Text(
                        '3명',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  ButtonTheme(
                    height: 300,
                    minWidth: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      color: Color(0xff366796),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectFourPeopleActivity()));
                      },
                      child: Text(
                        '4명',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox()
        ],
      )),
    );
  }
}

