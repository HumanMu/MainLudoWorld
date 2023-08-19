import '../game_engine/models/token.dart';

String splitByPoint(TokenType type) {
  List<String> splited = type.toString().split(".");

  return splited[1].toString();
}