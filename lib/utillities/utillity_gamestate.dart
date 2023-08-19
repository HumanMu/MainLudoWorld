import 'package:ludo_world_war/game_engine/models/token.dart';
import 'package:ludo_world_war/shared/functions.dart';
import '../game_engine/models/game_state.dart';


class Utility {
  int initialLength(TokenType type, GameState state) {
    String color = splitByPoint(type);
    int length = 0;

    switch(color) {
      case "blue": length = state.blueInitital.length; break;
      case "red": length = state.redInitital.length; break;
      case "green": length = state.greenInitital.length; break;
      case "yellow": length = state.yellowInitital.length; break;
    }
    return length;
  }



}