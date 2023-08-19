import 'package:flutter/material.dart';
import 'package:ludo_world_war/game_engine/path.dart';
import './position.dart';
import './token.dart';


class GameState with ChangeNotifier {
  List<Token?> gameTokens = List<Token?>.filled(16, null);
  late List<Position> starPositions;

  late List<Position> blueInitital;
  late List<Position> redInitital;
  late List<Position> greenInitital;
  late List<Position> yellowInitital;

  late List<Token> blueReached = [];
  late List<Token> redReached = [];
  late List<Token> greenReached = [];
  late List<Token> yellowReached = [];


  late int redHome = 0;
  late int greenHome = 0;
  late int yellowHome = 0;
  late int blueHome = 0;

  GameState() {
    gameTokens = [
      //Green Tokens home
      Token(TokenType.green, const Position(2, 2), TokenState.initial, 0),
      Token(TokenType.green, const Position(2, 3), TokenState.initial, 1),
      Token(TokenType.green, const Position(3, 2), TokenState.initial, 2),
      Token(TokenType.green, const Position(3, 3), TokenState.initial, 3),
      //Yellow Token
      Token(TokenType.yellow, const Position(2, 11), TokenState.initial, 4),
      Token(TokenType.yellow, const Position(2, 12), TokenState.initial, 5),
      Token(TokenType.yellow, const Position(3, 11), TokenState.initial, 6),
      Token(TokenType.yellow, const Position(3, 12), TokenState.initial, 7),
      // Blue Token
      Token(TokenType.blue, const Position(11, 11), TokenState.initial, 8),
      Token(TokenType.blue, const Position(11, 12), TokenState.initial, 9),
      Token(TokenType.blue, const Position(12, 11), TokenState.initial, 10),
      Token(TokenType.blue, const Position(12, 12), TokenState.initial, 11),
      // Red Token
      Token(TokenType.red, const Position(11, 2), TokenState.initial, 12),
      Token(TokenType.red, const Position(11, 3), TokenState.initial, 13),
      Token(TokenType.red, const Position(12, 2), TokenState.initial, 14),
      Token(TokenType.red, const Position(12, 3), TokenState.initial, 15),
    ];
    starPositions = [
      const Position(6, 1),
      const Position(2, 6),
      const Position(1, 8),
      const Position(6, 12),
      const Position(8, 13),
      const Position(12, 8),
      const Position(13, 6),
      const Position(8, 2)
    ];
    greenInitital = [];
    yellowInitital = [];
    blueInitital = [];
    redInitital = [];

  }
  moveToken(Token token, int steps) {
    Position destination;
    int pathPosition;
    if (token.tokenState == TokenState.home) return;
    if (token.tokenState == TokenState.initial && steps != 6) return;
    if (token.tokenState == TokenState.initial && steps == 6) {
      destination = _getPosition(token.type, 0, token);
      pathPosition = 0;

      _updateInitalPositions(token);
      _updateBoardState(token, destination, pathPosition);
      gameTokens[token.id]?.tokenPosition = destination;
      gameTokens[token.id]?.positionInPath = pathPosition;

      if(destination == const Position(7,6)
          || destination == const Position(6,7)
          || destination == const Position(7,8)
          || destination == const Position(8,7)){
        addToReachedDestination(token, token.type);
      }
      notifyListeners();
    } else if (token.tokenState != TokenState.initial) {
      int step = token.positionInPath + steps;
      if (step > 56) return;
      destination = _getPosition(token.type, step, token);
      pathPosition = step;
      var cutToken = _updateBoardState(token, destination, pathPosition);

      int duration = 0;
      for (int i = 1; i <= steps; i++) {
        duration = duration + 300;
        var future = Future.delayed(Duration(milliseconds: duration), () {
          int stepLoc = token.positionInPath + 1;
          gameTokens[token.id]?.tokenPosition =_getPosition(token.type,stepLoc, token);
          gameTokens[token.id]?.positionInPath = stepLoc;
          token.positionInPath = stepLoc;
          notifyListeners();
        });
      }
      if (cutToken != null) {
        int cutSteps = cutToken.positionInPath;
        for (int i = 1; i <= cutSteps; i++) {
          duration = duration + 70;
          var future2 = Future.delayed(Duration(milliseconds: duration), () {
            int stepLoc = cutToken.positionInPath - 1;
            gameTokens[cutToken.id]?.tokenPosition =
                _getPosition(cutToken.type, stepLoc, token);
            gameTokens[cutToken.id]?.positionInPath = stepLoc;
            cutToken.positionInPath = stepLoc;
            notifyListeners();
          });
        }

        var  future2 = Future.delayed(Duration(milliseconds: duration), () {
          _cutToken(cutToken);
          notifyListeners();
        });
      }
      if(destination == const Position(7,6)
          || destination == const Position(6,7)
          || destination == const Position(7,8)
          || destination == const Position(8,7)){
        addToReachedDestination(token, token.type);
      }

    }
  }

  Token? _updateBoardState(Token token, Position destination, int pathPosition){
    //when the destination is on any star
    if (starPositions.contains(destination)) {
      gameTokens[token.id]?.tokenState = TokenState.safe;
      return null;
    }
    List<Token?> tokenAtDestination = gameTokens.where((tkn) {
      if (tkn?.tokenPosition == destination) {
        return true;
      }
      return false;
    }).toList();
    //if no one at the destination
    if (tokenAtDestination.isEmpty) {
      gameTokens[token.id]?.tokenState = TokenState.normal;
      return null;
    }

    List<Token> tokenAtDestinationSameType = tokenAtDestination.where((tkn) {
      return tkn?.type == token.type;
    }).whereType<Token>().toList();

    if (tokenAtDestinationSameType.length == tokenAtDestination.length) {
      for (Token tkn in tokenAtDestinationSameType) {
        gameTokens[tkn.id]?.tokenState = TokenState.safeinpair;
      }
      gameTokens[token.id]?.tokenState = TokenState.safeinpair;
      return null;
    }

    Iterable<Token> filteredTokens = tokenAtDestination.whereType<Token>();
    if (tokenAtDestinationSameType.length < tokenAtDestination.length) {
      Token? cutToken;
      for (Token tkn in filteredTokens) {
        if (tkn.type != token.type && tkn.tokenState != TokenState.safeinpair){
          cutToken = tkn;
        } else if (tkn.type == token.type) {
          gameTokens[tkn.id]?.tokenState = TokenState.safeinpair;
        }
      }
      //place token
      gameTokens[token.id]?.tokenState =
      filteredTokens.isNotEmpty ? TokenState.safeinpair : TokenState.normal;
      return cutToken;
    }
    return token;
  }

  _updateInitalPositions(Token token) {
    switch (token.type) {
      case TokenType.green: greenInitital.add(token.tokenPosition); break;
      case TokenType.yellow: yellowInitital.add(token.tokenPosition); break;
      case TokenType.blue: blueInitital.add(token.tokenPosition); break;
      case TokenType.red: redInitital.add(token.tokenPosition); break;
    }
  }

  _cutToken(Token token) {
    switch (token.type) {
      case TokenType.green:
        {
          gameTokens[token.id]?.tokenState = TokenState.initial;
          gameTokens[token.id]?.tokenPosition = greenInitital.first;
          greenInitital.removeAt(0);
        }
        break;
      case TokenType.yellow:
        {
          gameTokens[token.id]?.tokenState = TokenState.initial;
          gameTokens[token.id]?.tokenPosition = yellowInitital.first;
          yellowInitital.removeAt(0);
        }
        break;
      case TokenType.blue:
        {
          gameTokens[token.id]?.tokenState = TokenState.initial;
          gameTokens[token.id]?.tokenPosition = blueInitital.first;
          blueInitital.removeAt(0);
        }
        break;
      case TokenType.red:
        {
          gameTokens[token.id]?.tokenState = TokenState.initial;
          gameTokens[token.id]?.tokenPosition = redInitital.first;
          redInitital.removeAt(0);
        }
        break;
    }
  }

  Position _getPosition(TokenType type, step, Token token) {
    Position destination;
    switch (type) {
      case TokenType.green:
        {
          List<int> node = Path.greenPath[step];
          destination = Position(node[0], node[1]);
          //destination == const Position(7,6)? greenReached.add(token) : " ";
        }
        break;
      case TokenType.yellow:
        {
          List<int> node = Path.yellowPath[step];
          destination = Position(node[0], node[1]);
          //destination == const Position(6,7)? greenReached.add(token) : " ";
        }
        break;
      case TokenType.blue:
        {
          List<int> node = Path.bluePath[step];
          destination = Position(node[0], node[1]);
          //destination == const Position(7,8)? greenReached.add(token) : " ";
        }
        break;
      case TokenType.red:
        {
          List<int> node = Path.redPath[step];
          destination = Position(node[0], node[1]);
          //destination == const Position(8,7)? greenReached.add(token) : " ";
        }
        break;
    }
    token.setTokenPosition(destination);
    //notifyListeners();
    return destination;
  }

  void addToReachedDestination(Token token, TokenType type){
    switch(type){
      case TokenType.green: greenReached.add(token); break;
      case TokenType.yellow: yellowReached.add(token); break;
      case TokenType.blue: blueReached.add(token); break;
      case TokenType.red: redReached.add(token); break;
      default: return;
    }
    notifyListeners();
  }

  void hommeState(token) {
    if(token.type == TokenType.red) {
      redHome++;
    } else if(token.type == TokenType.green) {
      greenHome++;
    }else if(token.type == TokenType.yellow) {
      yellowHome++;
    }else if(token.type == TokenType.blue) {
      blueHome++;
    }
    notifyListeners();
  }
}