import 'package:flutter/material.dart';
import 'package:ludo_world_war/constants/constant_variables.dart';
import 'package:provider/provider.dart';
import '../game_engine/models/dice_model.dart';
import '../game_engine/models/game_state.dart';
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
    await Future.delayed(const Duration(seconds: 1));
    dice.nextPlayer(color);
  }

  void checkMoveState(DiceModel dice, GameState state) {
    // Very important that you don't change the orders of the following states
    if(token.tokenState == TokenState.home) return; // If the clicked token has reached home
    if(token.tokenState == TokenState.initial && dice.diceOne != 6) return;
    if(dice.moveState == false) return;
    bool tokenAndPlayerColorResult = tokenAndPlayerColor(dice);
    if(tokenAndPlayerColorResult == false) return;
    bool moveSpace = hasEnoughSpaceToMove(dice, state); // If all other the above is correct check that there are enough space to move to
    if(moveSpace == false) return;

    // If all the above is good, do the bellow
    dice.diceOne==6
        ? state.moveToken(token, dice.diceOne)
        : {callNextPlayer(dice, state),
    };

    dice.setMoveState(false);
    dice.setDiceState(true);
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
          checkMoveState(dice, gameState);
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
                ]
            ),
          ),
        ),
      ),
    );
  }

  bool tokenAndPlayerColor(DiceModel dice) {
    if(token.type == dice.diceOneColor) {
      return true;
    }else{
      GlobalConstants.previousTokenType = token.type;
      return false;
    }
  }
  hasEnoughSpaceToMove(DiceModel dice, GameState state){
    int newPositionInPath = token.positionInPath + dice.diceOne;
    bool result = newPositionInPath <= 56 ? true : false;
    return result;
  }







}