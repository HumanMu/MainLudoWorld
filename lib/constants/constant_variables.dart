

import '../game_engine/models/token.dart';

class GlobalConstants {
  // Colors (constant but can be changed at runtime)
  //static const Color primaryColor = Color(0xFF42A5F5);
  //static const Color accentColor = Color(0xFFFF4081);

  // Strings (constant but can be changed at runtime)
  static int lastDiceNumber = 0;
  static int currentDiceNumber = 0;
  static TokenType previousTokenType = TokenType.green; // For no reason
  static String dicePath = "assets/dice/red/1.png";
}