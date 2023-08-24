import 'package:flutter/material.dart';
import 'package:ludo_world_war/constants/constant_variables.dart';
import 'package:ludo_world_war/game_engine/models/game_state.dart';
import 'package:ludo_world_war/game_engine/models/token.dart';
import 'package:provider/provider.dart';
import '../game_engine/models/dice_model.dart';
import '../shared/functions.dart';

class DiceWidget extends StatefulWidget {
  const DiceWidget({super.key});

  @override
  State<DiceWidget> createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  String nextPlayer = "";
  DiceModel diceModel = DiceModel();

  @override
  void initState() {
    super.initState();
    nextPlayer = diceModel.generateStarter();
  }

  void updateDices(DiceModel dice, GameState state) async{
    int generatedDice = 0;
    for (int i = 0; i < 6; i++) {
      var  duration = 200 + i * 10;
      await Future.delayed(Duration(milliseconds: duration),(){
        dice.generateDiceOne();
        generatedDice = dice.diceOne;
      });
    }
    moveToNextPlayerCheck(dice.diceColor, generatedDice, state);
  }
  void moveToNextPlayerCheck( TokenType type, int generatedDice, GameState state) async {
    final dice = Provider.of<DiceModel>(context, listen: false);
    //int tokensOnField = playGround(type, state);
    bool available = checkForMoveAvailableTokens(state, type, generatedDice);

    if(generatedDice != 6 && available == false) {
      String color = splitByPoint(type);
      await Future.delayed(const Duration(milliseconds: 500));
      dice.nextPlayer(color);
    }
    else{
      dice.diceState = false;
      dice.moveState = true;
    }
  }

  bool checkForMoveAvailableTokens(GameState state, TokenType type, int diceNr){
    Iterable<Token?> result = state.gameTokens
        .where((element) => element?.type==type
        && element?.tokenState != TokenState.initial
        && (57 - (element!.positionInPath + diceNr) > 0)).toList();

    return result.isEmpty? false: true;
  }

  @override
  Widget build(BuildContext context) {
    final dice = Provider.of<DiceModel>(context, listen: true);
    final state = Provider.of<GameState>(context, listen: true);

    final diceNumber = dice.diceOneCount;
    final diceColor = dice.diceOneColor;

    final Image img;
    img = diceImagePathFinder(diceNumber, diceColor);


    return Card(
      elevation: 10,
      child: SizedBox(
        height: 40,
        width: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () async{
                      if(dice.diceState == true){
                        updateDices(dice, state);
                      }
                      else{return;}
                    },
                    child: img,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  diceImagePathFinder(int diceNumber, TokenType diceColor){
    GlobalConstants.lastDiceNumber = GlobalConstants.currentDiceNumber;
    GlobalConstants.currentDiceNumber = diceNumber;
    String color = splitByPoint(diceColor);

    String dicePath = "assets/dice/$color/$diceNumber.png";
    var img = Image.asset(
      dicePath,
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );
    return img;
  }

  /*
  int playGround(TokenType type, GameState state) {
    String color = splitByPoint(type);

    int initialLength = 0;
    switch(color) {
      case "blue":
        initialLength = state.blueInitital.length;
        break;
      case "red":
        initialLength = state.redInitital.length;
        break;
      case "green":
        initialLength = state.greenInitital.length;
        break;
      case "yellow":
        initialLength = state.yellowInitital.length;
        break;
    }
    return initialLength;
  }
   */
}
