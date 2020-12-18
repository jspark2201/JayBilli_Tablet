import 'dart:async';

import 'package:flutter/material.dart';

class PlayingGameActivity extends StatefulWidget {
  final String firstSetNum;
  final String secondSetNum;
  final int firstSetColor;
  final int secondSetColor;

  //widget.firstSetNum 또는 widget.secondSetNum  형식을 통해 아래 클래스에서 사용 가능

  PlayingGameActivity(
      {@required this.firstSetNum,
      @required this.secondSetNum,
      @required this.firstSetColor,
      @required this.secondSetColor});

  @override
  _PlayingGameActivityState createState() => _PlayingGameActivityState();
}

class _PlayingGameActivityState extends State<PlayingGameActivity> {
  String defaultNum = '0';
  int _timeOutTime = 40;
  Timer _timeOutTimer;
  int fPAcquireScore = 0;
  int sPAcquireScore = 0;
  int customWhite = 4294967295;
  int customYellow = 4294961979;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startTimeOutTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424543),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: playerForm(1),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "1",
                        style: TextStyle(fontSize: 60, color: Colors.white),
                      ),
                      Text(
                        "00:00",
                        style: TextStyle(fontSize: 60, color: Colors.red),
                      ),
                      Container(
                        width: 400,
                        height: 300,
                        decoration: BoxDecoration(
                            color: Color(0xff424543),
                            image: DecorationImage(
                              image: ExactAssetImage('images/cover_img.png'),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff2C2E2C),
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0),
                              BoxShadow(
                                  color: Colors.grey[800],
                                  offset: Offset(-4.0, -4.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0)
                            ]),
                      ),
                      timeOutTimer(),
                      Container(
                        width: 400,
                        height: 100,
                        color: Colors.pink,
                      ),
                      SizedBox(),
                      ButtonTheme(
                        height: 100,
                        minWidth: 350,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: RaisedButton(
                          color: Color(0xff366796),
                          onPressed: () {
                            _startTimeOutTimer();
                          },
                          child: Text(
                            '턴 넘기기',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: playerForm(2),
                )
              ],
            ),
          ),
          ButtonTheme(
            height: 70,
            minWidth: 1200,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              color: Color(0xffFF6161),
              onPressed: () {
                finishGame();
              },
              child: Text(
                '종료하기',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget playerForm(var player) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(),
        Stack(
          overflow: Overflow.visible,
          children: [
            ButtonTheme(
              height: 630,
              minWidth: 430,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: RaisedButton(
                color: player == 1
                    ? Color(widget.firstSetColor)
                    : Color(widget.secondSetColor),
                onPressed: () {
                  print('$player번째 선수 점수 획득');
                  if (player == 1) {
                    setState(() {
                      fPAcquireScore++;
                    });
                    _startTimeOutTimer();
                  } else {
                    setState(() {
                      sPAcquireScore++;
                    });
                    _startTimeOutTimer();
                  }
                },
                child: SizedBox(
                  height: 630,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '비회원$player',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(),
                      Text(
                        player == 1 ? '$fPAcquireScore' : '$sPAcquireScore',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(),
                      Text(
                        '0.000',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: true,
                child: Positioned(
                  top: -50.0,
                  left: 165.0,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                  ),
                )),
            Positioned(
                top: -30.0,
                left: 185.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[800],
                            offset: Offset(2.0, 2.0),
                            spreadRadius: 1.0,
                            blurRadius: 3.0)
                      ]),
                  child: CircleAvatar(
                    child: Text(
                      player == 1 ? widget.firstSetNum : widget.secondSetNum,
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    radius: 30,
                    backgroundColor: player == 1
                        ? Color(widget.firstSetColor)
                        : Color(widget.secondSetColor),
                  ),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            scoreBtn(player, -1),
            scoreBtn(player, 1),
            scoreBtn(player, 2),
            scoreBtn(player, 3)
          ],
        ),
      ],
    );
  }

  Widget scoreBtn(var player, var num) {
    return ButtonTheme(
      height: 120,
      minWidth: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        color: player == 1
            ? Color(widget.firstSetColor)
            : Color(widget.secondSetColor),
        onPressed: () {
          if (player == 1) {
            setState(() {
              fPAcquireScore += num;
            });
            if (fPAcquireScore < 0) {
              fPAcquireScore = 0;
            }
          } else {
            setState(() {
              sPAcquireScore += num;
            });
            if (sPAcquireScore < 0) {
              sPAcquireScore = 0;
            }
          }
          _startTimeOutTimer();
        },
        child: Text(
          num < 0 ? '$num' : '+$num',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
    );
  }

  Widget timeOutTimer() {
    return Text(
      '$_timeOutTime',
      style: TextStyle(fontSize: 60, color: Colors.white),
    );
  }

  void _startTimeOutTimer() {
    _timeOutTime = 40;

    //중첩 감소를 없애기 위한 조건문(필수)
    if (_timeOutTimer != null) {
      _timeOutTimer.cancel();
    }
    _timeOutTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeOutTime > 0) {
          _timeOutTime--;
        } else {
          _timeOutTimer.cancel();
        }
      });
    });
  }

  void finishGame() {
    Navigator.pop(context);
  }
}
