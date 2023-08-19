import 'package:flutter/material.dart';
import 'package:ludo_world_war/constants/constant_variables.dart';
import 'package:ludo_world_war/game_engine/models/game_state.dart';
import 'package:ludo_world_war/game_engine/models/token.dart';
import 'package:provider/provider.dart';
import '../game_engine/models/dice_model.dart';
import '../game_engine/models/position.dart';
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
    int lastGeneratedDice = 0;
    for (int i = 0; i < 6; i++) {
      var  duration = 200 + i * 10;
      var future  = await Future.delayed(Duration(milliseconds: duration),(){
        dice.generateDiceOne();
        lastGeneratedDice = dice.diceOne;
      });
    }
    moveToNextPlayerCheck(dice.diceColor, lastGeneratedDice, state);
  }
  void moveToNextPlayerCheck( TokenType type, int tokenNumber, GameState state) async {
    final dice = Provider.of<DiceModel>(context, listen: false);
    int inPlayground = playGround(type, state);

    if(tokenNumber != 6 && inPlayground == 0) {
      String color = splitByPoint(type);
      await Future.delayed(const Duration(seconds: 1));
      dice.nextPlayer(color);
    }
    else{
      dice.diceState = false;
      dice.moveState = true;
    }

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
  
}

/*var img = Image.asset(
      diceYellowImages[newDice - 1],
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );*/

/*
class Dice extends StatelessWidget {
  const Dice({super.key});
  void updateDices(DiceModel dice) {
    for (int i = 0; i < 6; i++) {
      var  duration = 100 + i * 100;
      var future  = Future.delayed(Duration(milliseconds: duration),(){
        dice.generateDiceOne();
      });
    }
    //GlobalConstants.dicePath = diceImagePathFinder();
  }


  @override
  Widget build(BuildContext context) {
    //late AssetImage diceImagePath =  AssetImage();
    List<String> diceRedImages = [
      "assets/dice/red/1.png",
      "assets/dice/red/2.png",
      "assets/dice/red/3.png",
      "assets/dice/red/4.png",
      "assets/dice/red/5.png",
      "assets/dice/red/6.png",
    ];
    List<String> diceBlueImages = [
      "assets/dice/blue/1.png",
      "assets/dice/blue/2.png",
      "assets/dice/blue/3.png",
      "assets/dice/blue/4.png",
      "assets/dice/blue/5.png",
      "assets/dice/blue/6.png",
    ];
    List<String> diceGreenImages = [
      "assets/dice/green/1.png",
      "assets/dice/green/2.png",
      "assets/dice/green/3.png",
      "assets/dice/green/4.png",
      "assets/dice/green/5.png",
      "assets/dice/green/6.png",
    ];
    List<String> diceYellowImages = [
      "assets/dice/yellow/1.png",
      "assets/dice/yellow/2.png",
      "assets/dice/yellow/3.png",
      "assets/dice/yellow/4.png",
      "assets/dice/yellow/5.png",
      "assets/dice/yellow/6.png",
    ];
    final dice = Provider.of<DiceModel>(context);
    final c = dice.diceOneCount;
    var img = Image.asset(
      diceRedImages[c - 1],
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );
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
                    onTap: () => updateDices(dice),
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


  diceImagePathFinder(){
    String currentColor = GlobalConstants.lastDiceColor;
    String dicePath = GlobalConstants.dicePath;
    int currentDiceNumber = GlobalConstants.lastDiceNumber;
    int newDiceNumber = GlobalConstants.currentDiceNumber;
    String? color;
    if(currentDiceNumber != newDiceNumber) {
      color = diceColor(currentColor);
    }





  }

  String? diceColor(String currentColor){
    String? color;
    switch( currentColor) {
      case "red":
        color = "green";
      case "green":
        color = "yellow";
      case "yellow":
        color = "blue";
      case "blue":
        color = "red";
    }
    return color;
  }
}

 */