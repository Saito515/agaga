import 'package:flutter/material.dart';
import 'd_main.dart';
import 'dart:io';

const c_op = ['+', '-', '×', '÷'];

class Calculator {
  static var num = [];
  static var op = [];
//letterは上に出る字、bufferは一旦保持する字
  static String buffer = 0 as String;

  static void GetKey(String letter) {
    //四則演算
    if (c_op.contains(letter)) {
      //もしletterに演算子が含まれていたら
      op.add(letter); //演算子をop配列に追加
      num.add(double.parse(buffer)); //num配列の末尾にダブル型のbufferを追加
      buffer = ''; //bufferを空にする
    } //C
    else if (letter == 'c') {
      //もしletterがCならば
      num.clear(); //numの配列からすべてのオブジェクトを削除、lengthも0
      op.clear(); //numの配列からすべてのオブジェクトを削除、lengthも0
      buffer = ''; //bufferを空にする
    } //=
    else if (letter == '=') {
      return null;
    } //数字
    else {
      buffer += letter;
    }
  }

  static double result = 0.0;
  static String Execute() {
    num.add(double.parse(buffer)); //numに入力された値を追加

    if (num.length == 0) return '0'; //numの配列が0のとき0を返す

    result = num[0]; //resultには配列の0番目を格納

    for (int i = 0; i < op.length; i++) {
      //演算子の数の間
      if (op[i] == '+') {
        //足し算

        result += num[i + 1];
      } else if (op[i] == '-') {
        //引き算

        result -= num[i + 1];
      } else if (op[i] == '×') {
        //かけ算

        result *= num[i + 1];
      } else if (op[i] == '÷' && num[i + 1] != 0) //割り算
      {
        result /= num[i + 1];
      } else if (op[i] == '÷' && num[i + 1] == 0) //割り算
      {
        return '0除算';
        result /= num[i + 1];
      } else {
        return 'e'; //以外はエラー表示
      }
    }

//演算子ボタンの処理

    num.clear();
    op.clear();
    buffer = '';

    var resultStr = result.toString().split('.');
    return resultStr[1] == '0' ? resultStr[0] : result.toString();
  }
}
