import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ludo_world_war/game_engine/models/token.dart';

class DiceModel with ChangeNotifier {
  int diceOne = 1;
  TokenType diceColor = TokenType.blue;
  bool moveState = false;
  bool diceState = true;

  int get diceOneCount => diceOne;
  TokenType get diceOneColor => diceColor;
  bool get isDiceClicked =>  moveState;
  bool get onDiceClicked =>  diceState;

  void generateDiceOne() {
    diceOne = Random().nextInt(6) + 1;
    notifyListeners();
  }
  void setDiceState(bool state ) {
    diceState = state;
    notifyListeners();
  }

  void setMoveState(bool state){
    moveState = state;
    notifyListeners();
  }


  void startPlayerColor() {
    int starterPlayer = Random().nextInt(4) + 1;
    switch(starterPlayer) {
      case 1: diceColor = TokenType.red; break;
      case 2: diceColor = TokenType.green; break;
      case 3: diceColor = TokenType.yellow; break;
      case 4: diceColor = TokenType.blue; break;
    }
    notifyListeners();
  }
  void nextPlayer(String type){
    switch(type) {
      case "blue": diceColor = TokenType.red; break;
      case "red": diceColor = TokenType.green; break;
      case "green": diceColor = TokenType.yellow; break;
      case "yellow": diceColor = TokenType.blue; break;
    }
    notifyListeners();
  }


  String generateStarter(){
    List<String>diceList = ["red", "green", "yellow", "blue"];
    //diceColor = Random().nextInt(4) + 1;

    return diceList[diceOne];
  }
}