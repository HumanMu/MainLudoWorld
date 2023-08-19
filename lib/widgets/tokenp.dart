import 'package:flutter/material.dart';
import 'package:ludo_world_war/constants/constant_variables.dart';
import 'package:provider/provider.dart';
import '../game_engine/models/dice_model.dart';
import '../game_engine/models/game_state.dart';
import '../game_engine/models/position.dart';
import '../game_engine/models/token.dart';
import '../shared/functions.dart';

class Tokenp extends StatelessWidget {
  final Token token;
  final List<double> dimentions;
  final Function(Token)callBack;
  const Tokenp(this.token, this.dimentions, {super.key, required this.callBack});
  Color _getcolor() {
    switch (token.type) {
      case TokenType.green: return Colors.green;
      case TokenType.yellow: return Colors.yellow;
      case TokenType.blue: return Colors.blue;
      case TokenType.red: return Colors.red;
      default : return Colors.red;
    }
  }
  void callNextPlayer(DiceModel dice, GameState gameState) async {
    String color = splitByPoint(dice.diceColor);
    await gameState.moveToken(token, dice.diceOne);
    //bool reached = isReachedDestination(token, token.type);    // Check if the user reached home
    await Future.delayed(const Duration(seconds: 1));
    dice.nextPlayer(color);
  }


  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final dice = Provider.of<DiceModel>(context);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      left: dimentions[0],
      top: dimentions[1],
      width: dimentions[2],
      height: dimentions[3],
      child: GestureDetector(
        onTap: (){
          if(dice.moveState == true) {
            bool result = idetifyClicks(dice);
            if(result) {
              dice.diceOne==6
                  ? gameState.moveToken(token, dice.diceOne)
                  : {callNextPlayer(dice, gameState),
              };
            }
            else{
              return;
            }
          }
          else{
            return;
          }
          dice.setMoveState(false);
          dice.setDiceState(true);
        },
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getcolor(),
                boxShadow: [
                  BoxShadow(
                    color: _getcolor(),
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                  )
                ]),
          ),
        ),
      ),
    );
  }

  bool idetifyClicks(DiceModel dice) {
    if(token.type == dice.diceOneColor) {
      return true;
    }else{
      GlobalConstants.previousTokenType = token.type;
      return false;
    }
  }

  bool isReachedDestination(Token token, type) {
    bool isReached = false;
    switch(type) {
      case TokenType.green:
        isReached = token.tokenPosition == const Position(7,6)? true : false;
        break;
      case TokenType.yellow:
        isReached = token.tokenPosition == const Position(6,7)? true : false;
        break;
      case TokenType.blue:
        isReached = token.tokenPosition == const Position(7,8)? true : false;
        break;
      case TokenType.red:
        isReached = token.tokenPosition == const Position(8,7)? true : false;
        break;
    }
    return isReached;
  }

}