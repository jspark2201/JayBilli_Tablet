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
  bool firstPlayerTurn = true;
  int inning = 1;
  int inningCycle = 0;
  String fPAverage = 0.toStringAsFixed(3);
  String sPAverage = 0.toStringAsFixed(3);
  String _hourGameTime = '00';
  String _minuteGameTime = '00';
  Timer _gameTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startTimeOutTimer();
    _setFirstTurn();
    _startGameTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _timeOutTimer.cancel();
    _gameTimer.cancel();
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
                  child: firstPlayerForm(),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '$inning',
                        style: TextStyle(fontSize: 60, color: Colors.white),
                      ),
                      Text(
                        _hourGameTime + ':' + _minuteGameTime,
                        style: TextStyle(fontSize: 30, color: Colors.red),
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
                      timerBar(_timeOutTime),
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
                            changeTurn();
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
                  child: secondPlayerForm(),
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
                terminationGame();
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

  Widget firstPlayerForm() {
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
                color: Color(widget.firstSetColor),
                onPressed: () {
                  fPTapped();
                  _startTimeOutTimer();
                  finishGame(1);
                },
                child: SizedBox(
                  height: 630,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '비회원1',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(),
                      Text(
                        '$fPAcquireScore',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(),
                      Text(
                        fPAverage,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: firstPlayerTurn,
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
                      widget.firstSetNum,
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    radius: 30,
                    backgroundColor: Color(widget.firstSetColor),
                  ),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            scoreBtn(1, -1),
            scoreBtn(1, 1),
            scoreBtn(1, 2),
            scoreBtn(1, 3)
          ],
        ),
      ],
    );
  }

  Widget secondPlayerForm() {
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
                color: Color(widget.secondSetColor),
                onPressed: () {
                  sPTapped();
                  _startTimeOutTimer();
                  finishGame(2);
                },
                child: SizedBox(
                  height: 630,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '비회원2',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(),
                      Text(
                        '$sPAcquireScore',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(),
                      Text(
                        sPAverage,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: !firstPlayerTurn,
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
                      widget.secondSetNum,
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    radius: 30,
                    backgroundColor: Color(widget.secondSetColor),
                  ),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            scoreBtn(2, -1),
            scoreBtn(2, 1),
            scoreBtn(2, 2),
            scoreBtn(2, 3)
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
              if (firstPlayerTurn) {
                fPAcquireScore += num;
                if(fPAcquireScore > int.parse(widget.firstSetNum)) {  //점수가 오버된 경우 setNum을 넘지 않게 하는 조건
                  fPAcquireScore = int.parse(widget.firstSetNum);
                }
                fPAvgCalculation();
                finishGame(player);
              } else {
                changeTurn();
              }
            });
            if (fPAcquireScore < 0) {
              fPAcquireScore = 0;
            }
          } else {
            setState(() {
              if (!firstPlayerTurn) {
                sPAcquireScore += num;
                if(sPAcquireScore > int.parse(widget.secondSetNum)) {  //점수가 오버된 경우 setNum을 넘지 않게 하는 조건
                  sPAcquireScore = int.parse(widget.secondSetNum);
                }
                sPAvgCalculation();
                finishGame(player);
              } else {
                changeTurn();
              }
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

  Widget timerBar(int time) {
    return Container(
      width: 406,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: time > 36,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xff64AC3F),
            ),
          ),
          Visibility(
            visible: time > 32,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffC3E63F),
            ),
          ),
          Visibility(
            visible: time > 28,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffE1E63F),
            ),
          ),
          Visibility(
            visible: time > 24,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffE6E33F),
            ),
          ),
          Visibility(
            visible: time > 20,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffE6DD3F),
            ),
          ),
          Visibility(
            visible: time > 16,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffF9D907),
            ),
          ),
          Visibility(
            visible: time > 12,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffF49900),
            ),
          ),
          Visibility(
            visible: time > 8,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffF87405),
            ),
          ),
          Visibility(
            visible: time > 4,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffF25410),
            ),
          ),
          Visibility(
            visible: time > 0,
            child: Container(
              width: 40,
              height: 100,
              color: Color(0xffE63F3F),
            ),
          ),
        ],
      ),
    );
  }

  Widget finishAlertDialog(int player) {
    return AlertDialog(
      title: Center(child: Text('승리', style: TextStyle(fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: Container(
        height: 400,
        width: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text('비회원$player', style: TextStyle(fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),),
            FlatButton(onPressed: () {

              Navigator.pop(context);
              terminationGame();
            }, child: Text('종료', style: TextStyle(color: Colors.red, fontSize: 20),))
          ],
        ),
      ),
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

  void _startGameTimer() {
    int _hour = 0;
    int _minute = 0;

    _gameTimer = Timer.periodic(Duration(seconds: 60), (timer) {
      setState(() {
        if (_minute < 59) {
          _minute++;
          if (_minute < 10) {
            _minuteGameTime = '0' + _minute.toString();
          } else {
            _minuteGameTime = _minute.toString();
          }
        } else {
          _minute = 0;
          _minuteGameTime = '00';
          _hour++;
          if (_hour < 10) {
            _hourGameTime = '0' + _hour.toString();
          } else {
            _hourGameTime = _hour.toString();
          }
        }
      });
    });
  }

  void fPTapped() {
    setState(() {
      if (firstPlayerTurn) {
        fPAcquireScore++;
        fPAvgCalculation();
      } else {
        changeTurn();
      }
    });
  }

  void sPTapped() {
    setState(() {
      if (!firstPlayerTurn) {
        sPAcquireScore++;
        sPAvgCalculation();
      } else {
        changeTurn();
      }
    });
  }

  void fPAvgCalculation() {
    setState(() {
      fPAverage = (fPAcquireScore / inning).toStringAsFixed(3);
    });
  }

  void sPAvgCalculation() {
    setState(() {
      sPAverage = (sPAcquireScore / inning).toStringAsFixed(3);
    });
  }

  void changeTurn() {
    setState(() {
      firstPlayerTurn = !firstPlayerTurn;

      if (inningCycle != 0 && inningCycle % 2 == 1) {
        inning++;
      }
      inningCycle++;
    });
    fPAvgCalculation();
    sPAvgCalculation();
  }

  void _setFirstTurn() {
    if (widget.firstSetColor == customWhite) {
      firstPlayerTurn = true;
    } else {
      firstPlayerTurn = false;
    }
  }

  void finishGame(int player) {
    if (player == 1) {
      fPAcquireScore >= int.parse(widget.firstSetNum)
          ? showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return finishAlertDialog(player);
              })
          : null;
    }

    if (player == 2) {
      sPAcquireScore >= int.parse(widget.secondSetNum)
          ? showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return finishAlertDialog(player);
              })
          : null;
    }
  }

  void terminationGame() {
    Navigator.pop(context);
  }
}
