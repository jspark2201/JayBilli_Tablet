import 'package:flutter/material.dart';
import 'package:jaybilli_tablet/fourBallsActivity.dart';
import 'package:jaybilli_tablet/poolActivity.dart';
import 'package:jaybilli_tablet/threeCushionActivity.dart';

class EventSettingActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424543),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            builder: (context) => ThreeCushionActivity()));
                  },
                  child: Text(
                    '3구',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              ButtonTheme(
                height: 300,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: RaisedButton(
                  color: Color(0xffFF6161),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FourBallsActivity()));
                  },
                  child: Text(
                    '4구',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              ButtonTheme(
                height: 300,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: RaisedButton(
                  color: Color(0xffF6D161),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PoolActivity()));
                  },
                  child: Text(
                    '포켓볼',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
