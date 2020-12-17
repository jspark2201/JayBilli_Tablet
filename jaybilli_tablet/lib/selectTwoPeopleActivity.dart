import 'package:flutter/material.dart';

class SelectTwoPeopleActivity extends StatefulWidget {
  @override
  _SelectTwoPeopleActivityState createState() =>
      _SelectTwoPeopleActivityState();
}

class _SelectTwoPeopleActivityState extends State<SelectTwoPeopleActivity> {
  var firstPlayerColor = 0xffffffff;
  var secondPlayerColor = 0xffffeb3b;
  var testNum = '0';
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
            barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    backgroundColor: Color(playerColor),
                    content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return SizedBox(
                        width: 1100,
                        height: 700,
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() => settingNum='0');
                                            Navigator.of(context).pop();
                                          },
                                          icon: CircleAvatar(
                                            child: Icon(Icons.close, color: Colors.white,),
                                            radius: 50,
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                        Text('점수 입력', style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 600,
                                      width: 500,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
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
                                      child: Center(child: Text(settingNum, style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),)),
                                    ),
                                    Container(
                                        height: 600,
                                        width: 500,
                                        //color: Colors.green,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                calculatorBtn('7', setState),
                                                calculatorBtn('8', setState),
                                                calculatorBtn('9', setState),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                calculatorBtn('4', setState),
                                                calculatorBtn('5', setState),
                                                calculatorBtn('6', setState),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                calculatorBtn('1', setState),
                                                calculatorBtn('2', setState),
                                                calculatorBtn('3', setState),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                deleteNumBtn('취소', setState),
                                                calculatorBtn('0', setState),
                                                ButtonTheme(
                                                  height: 120,
                                                  minWidth: 120,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                  child: RaisedButton(
                                                    color: Colors.grey[200],
                                                    onPressed: () {
                                                      setNumber(settingNum);
                                                      setState(()=> settingNum='0');
                                                      Navigator.of(context).pop(testNum);
                                                    },
                                                    child: Text('확인',
                                                      style: TextStyle(color: Colors.black, fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox()
                              ],
                            ),
                          ],

                        ),
                      );
                    }));
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

  Widget calculatorBtn(var key, StateSetter setState) {
    return ButtonTheme(
      height: 120,
      minWidth: 120,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        color: Colors.grey[200],
        onPressed: () {
          pressNumberBtn(key, setState);
        },
        child: Text(
          key,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Widget deleteNumBtn(var key, StateSetter setState) {
    return ButtonTheme(
      height: 120,
      minWidth: 120,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        color: Colors.grey[200],
        onPressed: () {
          setState(() => settingNum='0');
        },
        child: Text(
          key,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Widget okNumBtn(var key, StateSetter setState) {
    return ButtonTheme(
      height: 120,
      minWidth: 120,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        color: Colors.grey[200],
        onPressed: () {
          Navigator.of(context).pop();
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

  //공 색을 변경하는 함수
  void changeColor() {
    var temp;
    setState(() {
      temp = firstPlayerColor;
      firstPlayerColor = secondPlayerColor;
      secondPlayerColor = temp;
    });
  }

  //번호를 누르면 점수를 설정하는 함수
  void pressNumberBtn(var key, StateSetter setState) {
    setState(() {
      // '0' 초기값으로 설정되어 있다면 누른 숫자로 변경 ex) 0 -> 6
      if (settingNum=='0') {
        settingNum = key;
      } else {
        //이미 숫자가 설정되어 있다면 누른 숫자를 이미 설정된 숫자 뒤에 붙인 후 변경 ex) 1 -> 17
        settingNum += key;
      }
    });
  }

  //점수 설정 뒤 확인버튼을 누르면 설정한 점수를 반영하는 함수
  void setNumber(var num) {
    setState(() {
      testNum = num;
    });
  }
}
