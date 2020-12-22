import 'package:flutter/material.dart';
import 'package:jaybilli_tablet/playingGameActivity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectTwoPeopleActivity extends StatefulWidget {
  @override
  _SelectTwoPeopleActivityState createState() =>
      _SelectTwoPeopleActivityState();
}

class _SelectTwoPeopleActivityState extends State<SelectTwoPeopleActivity> {
  var firstPlayerColor = 0xffffffff;
  var secondPlayerColor = 0xffffeb3b;
  var firstPlayerNum = '0';
  var secondPlayerNum = '0';
  var settingNum = '0';
  var _firstVisible = true;
  var _secondVisible = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController(text: '');
  TextEditingController _pwController = TextEditingController(text: '');
  TextEditingController _formController = TextEditingController(text: '@naver.com');

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //키보드가 올라와도 무시하는 옵션
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(children: [
                        //비회원이나 회원으로 세팅한 후 점수 설정 위젯
                        Visibility(
                            visible: !_firstVisible,
                            child: completeSettingBox(
                                firstPlayerColor, 1, firstPlayerNum)),
                        //비회원 또는 회원 버튼을 클릭할 수 있는 위젯
                        Visibility(
                            visible: _firstVisible,
                            child: incompleteSettingBox(firstPlayerColor, 1)),
                      ]),
                      Stack(
                        children: [
                          //비회원이나 회원으로 세팅한 후 점수 설정 위젯
                          Visibility(
                              visible: !_secondVisible,
                              child: completeSettingBox(
                                  secondPlayerColor, 2, secondPlayerNum)),
                          //비회원 또는 회원 버튼을 클릭할 수 있는 위젯
                          Visibility(
                              visible: _secondVisible,
                              child:
                              incompleteSettingBox(secondPlayerColor, 2)),
                        ],
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
                        if (firstPlayerNum != '0' && secondPlayerNum != '0') {
                          startGame();
                        } else {
                          pleasSettingNum();
                        }
                      },
                      child: Text(
                        '시작하기',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget incompleteSettingBox(var color, var player) {
    return Container(
      height: 600,
      width: 500,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[850],
              offset: Offset(
                4.0,
                4.0,
              ),
              spreadRadius: 1.0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          memberBtn(player),
          nonMemberBtn(context, player, color),
        ],
      ),
    );
  }

  Widget completeSettingBox(var color, var player, var number) {
    return Container(
      height: 600,
      width: 500,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[850],
              offset: Offset(
                4.0,
                4.0,
              ),
              spreadRadius: 1.0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 40,
                  onPressed: () {
                    reSettingBtn(context, player, color);
                  })
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('비회원$player',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text(
                  number,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          SizedBox()
        ],
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() => settingNum = '0');
                                        Navigator.of(context).pop();
                                      },
                                      icon: CircleAvatar(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        radius: 50,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      '점수 입력',
                                      style: TextStyle(
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
                                          )
                                        ],
                                      ),
                                      child: Center(
                                          child: Text(
                                        settingNum,
                                        style: TextStyle(
                                            fontSize: 70,
                                            fontWeight: FontWeight.bold),
                                      )),
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
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: RaisedButton(
                                                    color: Color(0xff366796),
                                                    onPressed: () {
                                                      setNumber(
                                                          player, settingNum);
                                                      setState(() =>
                                                          settingNum = '0');
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      '확인',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
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
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              if(player == 1) {
                return _memberDialog(1);
              } else {
                return _memberDialog(2);
              }
            },
          );
        },
        color: Color(0xff366796),
        child: Text(
          '회원',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }

  Widget _memberDialog(var player) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        return AlertDialog(
          backgroundColor: Color(0xff366796),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: 1100,
                height: 500,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Positioned(
                        left: 250,
                        top: -120,
                        child: Image.asset(
                          'images/title_img2.png',
                          width: 600,
                          height: 200,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '아이디',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _idController,
                                style: TextStyle(fontSize: 30),
                                decoration: getTextFieldDecor('아이디'),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return '올바른 형식으로 입력해주세요.';
                                  }
                                  //_idController.text  = value + '@naver.com';
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                '비밀번호',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _pwController,
                                obscureText: true,
                                style: TextStyle(fontSize: 30),
                                decoration: getTextFieldDecor('비밀번호'),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return '비밀번호를 입력해 주세요.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ), // path: lib/widgets/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonTheme(
                              height: 70,
                              minWidth: 200,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: RaisedButton(
                                onPressed: () {
                                  //종료했을 때, text field 값을 null로 초기화
                                  _idController.text = '';
                                  _pwController.text = '';
                                  Navigator.pop(context);
                                },
                                color: Color(0xffFF6161),
                                child: Text(
                                  '취소',
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            ButtonTheme(
                              height: 70,
                              minWidth: 200,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: RaisedButton(
                                onPressed: () {
                                  //올바른 형식으로 아이디 및 패스워드가 입력된 경우
                                  if (_formKey.currentState.validate()) {
                                    print(_idController.text);
                                    print(_pwController.text);
                                    if(player == 1) {
                                      _fMLogin;
                                    } else {
                                      _sMLogin;
                                    }

                                  }
                                },
                                color: Color(0xffFF6161),
                                child: Text(
                                  '로그인',
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }

  get _register async {
    String errorMessage;
    try {
      final AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _idController.text+'@gmail.com', password: _pwController.text);

      final FirebaseUser user = result.user;
    } catch(error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  //첫번째 플레이어 로그인 함수
  get _fMLogin async {
    String errorMessage;
    try {
      final AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _idController.text+'@gmail.com', password: _pwController.text);

      final FirebaseUser user = result.user;

      _idController.text = '';
      _pwController.text = '';
      Navigator.pop(context);
      setState(() {
        _firstVisible = false;
      });

    } catch(error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }
  //두번째 플레이어 로그인 함수
  get _sMLogin async {
    String errorMessage;
    try {
      final AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _idController.text+'@gmail.com', password: _pwController.text);

      final FirebaseUser user = result.user;

      _idController.text = '';
      _pwController.text = '';
      Navigator.pop(context);
      setState(() {
        _secondVisible = false;
      });

    } catch(error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  InputDecoration getTextFieldDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        errorStyle: TextStyle(fontSize: 20, color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.grey[100],
        filled: true);
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
          setState(() => settingNum = '0');
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PlayingGameActivity(
                firstSetNum: firstPlayerNum,
                secondSetNum: secondPlayerNum,
                firstSetColor: firstPlayerColor.toInt(),
                secondSetColor: secondPlayerColor.toInt())));
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
      if (settingNum == '0') {
        settingNum = key;
      } else {
        //이미 숫자가 설정되어 있다면 누른 숫자를 이미 설정된 숫자 뒤에 붙인 후 변경 ex) 1 -> 17
        settingNum += key;
      }
    });
  }

  //점수 설정 뒤 확인버튼을 누르면 설정한 점수를 반영하는 함수
  void setNumber(var player, var num) {
    setState(() {
      if (player == 1) {
        firstPlayerNum = num;
        _firstVisible = false;
      } else if (player == 2) {
        secondPlayerNum = num;
        _secondVisible = false;
      }
    });
  }

  //점수를 수정하고 싶을 때 setting 버튼을 누르면 호출되는 함수
  void reSettingBtn(BuildContext context, var player, var playerColor) {
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
                                  setState(() => settingNum = '0');
                                  Navigator.of(context).pop();
                                },
                                icon: CircleAvatar(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  radius: 50,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              Text(
                                '점수 입력',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox()
                            ],
                          ),
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
                                    )
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  settingNum,
                                  style: TextStyle(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold),
                                )),
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
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: RaisedButton(
                                              color: Color(0xff366796),
                                              onPressed: () {
                                                setNumber(player, settingNum);
                                                setState(
                                                    () => settingNum = '0');
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                '확인',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
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
  }

  void pleasSettingNum() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SizedBox(
                height: 200,
                width: 400,
                child: Center(
                    child: Text(
                  '점수를 입력해주세요',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ))),
          );
        });
  }
}
