import 'dart:js_util';

import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'dart:async';
import 'dart:collection';
import 'dart:io';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '電卓アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'calc app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum CALC_TYPE { add, sub, multi, div }

class _MyHomePageState extends State<MyHomePage> {
  double _setNumber = 0;
  double _displayNumber = 0;
  double _firstNum = 0;
  String _calcType = " ";
  int _displayPow = 0;
  bool _decimalFlag = false;

  void _setNum(double num) {
    _displayPow = 0;
    if (_displayNumber == _setNumber) {
      if (10000000000 > _displayNumber) {
        setState(() {
          if (!_decimalFlag)
            _displayNumber = _displayNumber * 10 + num;
          else {
            int count = 1;
            for (int i = 0;
                _displayNumber * Math.pow(10, i) !=
                    (_displayNumber * Math.pow(10, i)).ceil();
                i++) {
              count++;
            }
            _displayNumber = double.parse(
                (_displayNumber + (num / Math.pow(10, count)))
                    .toStringAsFixed(count));
            _checkDecimal();
          }
          _setNumber = _displayNumber;
        });
      }
    } else {
      setState(() {
        _displayNumber = num;
        _setNumber = _displayNumber;
        _calcType;
      });
    }
  }

  void _calcBtnPressed(CALC_TYPE type) {
    _setNumber = _displayNumber;
    _firstNum = _setNumber;
    _setNumber = 0;
    _displayNumber = 0;
    _calcType;
  }

  void _calcAdd() {
    setState(() {
      _displayNumber = _firstNum + _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcSub() {
    setState(() {
      _displayNumber = _firstNum - _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcMulti() {
    setState(() {
      _displayNumber = _firstNum * _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcDiv() {
    setState(() {
      _displayNumber = _firstNum / _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _checkDecimal() {
    double checkNum = _displayNumber;
    if (100000000000 < _displayNumber ||
        _displayNumber == _displayNumber.toInt()) {
      for (int i = 0; 100000000000 < _displayNumber / Math.pow(10, i); i++) {
        _displayPow = i;
        checkNum = checkNum / 10;
      }
      _displayNumber = checkNum.floor().toDouble();
    } else {
      int count = 0;
      for (int i = 0; 1 < _displayNumber / Math.pow(10, i); i++) {
        count = i;
      }
      int displayCount = 10 - count;
      _displayNumber =
          double.parse(_displayNumber.toStringAsFixed(displayCount));
    }
  }

  void _error() {
    _displayNumber = "ERROR" as double;
  }

  void _clearNum() {
    setState(() {
      _setNumber = 0;
      _displayNumber = 0;
      _firstNum = 0;
      _calcType;
      _displayPow = 0;
      _decimalFlag = false;
    });
  }

  void _clearEntryNum() {
    setState(() {
      _setNumber = 0;
      _displayNumber = 0;
      _calcType;
      _displayPow = 0;
      _decimalFlag = false;
    });
  }

  void _invertedNum() {
    //逆転した数字？
    setState(() {
      _displayNumber = -_displayNumber;
      _setNumber = -_setNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 20,
            child: _displayPow > 0
                ? Text(
                    "10^${_displayPow.toString()}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                : Container(),
          ),
          Text(
            _displayNumber == _displayNumber.toInt()
                ? _displayNumber.toInt().toString()
                : _displayNumber.toString(),
            style: TextStyle(
              fontSize: 60,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "CE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),
                          onPressed: () {
                            _clearEntryNum();
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "C",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _clearNum();
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "÷",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _calcBtnPressed(CALC_TYPE.div);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "７",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(7);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "８",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(8);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "９",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(9);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "×",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _calcBtnPressed(CALC_TYPE.multi);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "４",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(4);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "５",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(5);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "６",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(6);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _calcBtnPressed(CALC_TYPE.sub);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "１",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(1);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "２",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(2);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "３",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(3);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "+",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _calcBtnPressed(CALC_TYPE.add);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "+/-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          onPressed: () {
                            _invertedNum();
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "０",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _setNum(0);
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            ".",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            _decimalFlag = true;
                          },
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextButton(
                          child: Text(
                            "=",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          onPressed: () {
                            switch (_calcType) {
                              case CALC_TYPE.add:
                                _calcAdd();

                                break;
                              case CALC_TYPE.sub:
                                _calcSub();
                                break;
                              case CALC_TYPE.multi:
                                _calcMulti();
                                break;
                              case CALC_TYPE.div:
                                _calcDiv();
                                break;
                              default:
                                _error();
                                break;
                            }
                          },
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
