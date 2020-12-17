import 'package:flutter/material.dart';

class SelectTwoPeopleActivity extends StatefulWidget {
  @override
  _SelectTwoPeopleActivityState createState() =>
      _SelectTwoPeopleActivityState();
}

class _SelectTwoPeopleActivityState extends State<SelectTwoPeopleActivity> {
  var firstPlayerColor = 0xffffffff;
  var secondPlayerColor = 0xffffeb3b;
  var testNum = 0;
  var settingNum = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424543),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                IconButton(
                    icon: Image.asset('images/switch.png'),
                    iconSize: 60,
                    onPressed: () {
                      changeColor();
                    }),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 600,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Color(firstPlayerColor),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[850],
                                offset: Offset(
                                  4.0,
                                  4.0,
                                ),
                                //blurRadius: 15.0,
                                spreadRadius: 1.0)
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            memberBtn(1),
                            nonMemberBtn(context, 1, firstPlayerColor),
                          ],
                        ),
                      ),
                      Text('$testNum'),
                      Container(
                        height: 600,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Color(secondPlayerColor),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[850],
                                offset: Offset(
                                  4.0,
                                  4.0,
                                ),
                                //blurRadius: 15.0,
                                spreadRadius: 1.0)
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            memberBtn(2),
                            nonMemberBtn(context, 2, secondPlayerColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ButtonTheme(
                    height: 100,
                    minWidth: 1200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      color: Color(0xffFF6161),
                      onPressed: () {
                        startGame();
                      },
                      child: Text(
                        '시작하기',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nonMemberBtn(BuildContext context, var player, var playerColor) {
    return ButtonTheme(
      height: 150,
      minWidth: 300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    backgroundColor: Color(playerColor),
                    content: SizedBox(
                      width: 1100,
                      height: 700,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Positioned(
                            right: -50.0,
                            top: -50.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                radius: 30,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                  child: Text(
                                    '점수 입력',
                                    style: TextStyle(
                                        fontSize: 30, fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 600,
                                    width: 500,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[500],
                                          offset: Offset(
                                            2.0,
                                            2.0,
                                          ),
                                          blurRadius: 2.0,
                                          //spreadRadius: 1.0
                                        )
                                      ],
                                    ),
                                    child: Center(child: Text(settingNum)),
                                  ),
                                  Container(
                                      height: 600,
                                      width: 500,
                                      //color: Colors.green,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              calculatorBtn('7'),
                                              calculatorBtn('8'),
                                              calculatorBtn('9'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              calculatorBtn('4'),
                                              calculatorBtn('5'),
                                              calculatorBtn('6'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              calculatorBtn('1'),
                                              calculatorBtn('2'),
                                              calculatorBtn('3'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              calculatorBtn('취소'),
                                              calculatorBtn('0'),
                                              calculatorBtn('확인'),
                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ));
              });
        },
        color: Colors.grey,
        child: Text(
          '비회원',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }

  Widget memberBtn(var player) {
    return ButtonTheme(
      height: 150,
      minWidth: 300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        onPressed: () {},
        color: Color(0xff366796),
        child: Text(
          '회원',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }

  Widget calculatorBtn(var key) {
    return ButtonTheme(
      height: 120,
      minWidth: 120,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        color: Colors.grey[200],
        onPressed: () {
          pressNumberBtn(key);
        },
        child: Text(
          key,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }




  void startGame() {
    print('게임 시작');
  }

  void changeColor() {
    var temp;
    setState(() {
      temp = firstPlayerColor;
      firstPlayerColor = secondPlayerColor;
      secondPlayerColor = temp;
    });
  }

  void pressNumberBtn(var key) {

    setState(() {
      settingNum = key;
    });
  }

}


