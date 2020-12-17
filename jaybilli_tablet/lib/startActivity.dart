import 'package:flutter/material.dart';
import 'package:jaybilli_tablet/eventSettingActivity.dart';

class StartActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff424543),
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(child: Image.asset('images/title_img.png')),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('images/logo_img.png')),
              SizedBox(
                height: 80,
                width: 400,
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: RaisedButton(
                    color: Color(0xffFF6161),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EventSettingActivity()));
                    },
                    child: Text(
                      '시작하기',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
