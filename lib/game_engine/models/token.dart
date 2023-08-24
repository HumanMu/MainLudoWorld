
import 'package:flutter/cupertino.dart';
import './position.dart';

enum TokenType {
  green,
  yellow,
  blue,
  red
}
enum TokenState{
  initial,
  home,
  normal,
  safe,
  safeinpair
}

class Token extends ChangeNotifier
{
  final int  id;
  final TokenType type;
  Position tokenPosition;
  TokenState tokenState;
  late int positionInPath = 0;

  Position get movedToken => tokenPosition;
  Token(
      this.type,
      this.tokenPosition,
      this.tokenState,
      this.id
  );

  void setTokenPosition(Position position) {
    tokenPosition = position;
    notifyListeners();
  }

}

