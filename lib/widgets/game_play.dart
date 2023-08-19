import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../game_engine/models/game_state.dart';
import '../game_engine/models/token.dart';
import './board.dart';
import './tokenp.dart';
class GamePlay extends StatefulWidget {
  final GlobalKey keyBar;
  final GameState gameState;
  const GamePlay(this.keyBar,this.gameState, {super.key});
  @override
  State<GamePlay> createState() => _GamePlayState();
}
class _GamePlayState extends State<GamePlay> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((context) {
      setState(() {
        boardBuild = true;
      });
    });

  }
  callBack(Token token){
    if (kDebugMode) {
      print(token);
    }
  }
  bool boardBuild = false;
  List<double> dimentions = [0, 0, 0, 0];
  final List<List<GlobalKey>> keyRefrences =_getGlobalKeys();
  static List<List<GlobalKey>> _getGlobalKeys() {
    List<List<GlobalKey>> keysMain = [];
    for (int i = 0; i < 15; i++) {
      List<GlobalKey> keys = [];
      for (int j = 0; j < 15; j++) {
        keys.add(GlobalKey());
      }
      keysMain.add(keys);
    }
    return keysMain;
  }
  List<double> _getPosition(int row, int column) {
    var listFrame = <double>[]; //List<double>.filled(4, 0);
    double x;
    double y;
    double w;
    double h;
    final cellBoxKey = keyRefrences[row][column];
    if(cellBoxKey.currentContext == null) {
      return [0,0,0,0];
    }

    final RenderBox renderBoxBar = widget.keyBar.currentContext!.findRenderObject() as RenderBox;
    final sizeBar = renderBoxBar.size;
    final RenderBox renderBoxCell = cellBoxKey.currentContext!.findRenderObject() as RenderBox;
    final positionCell = renderBoxCell.localToGlobal(Offset.zero);
    x = positionCell.dx + 1;
    y = (positionCell.dy - sizeBar.height + 1);
    w = renderBoxCell.size.width - 2;
    h = renderBoxCell.size.height - 2;
    listFrame.add(x);
    listFrame.add(y);
    listFrame.add(w);
    listFrame.add(h);
    return listFrame;
  }
  List<Tokenp> _getTokenList(){
    List<Tokenp> widgets = [];
    for(Token token in widget.gameState.gameTokens.whereType<Token>())
    {
      widgets.add(Tokenp(token,_getPosition(token.tokenPosition.row,
          token.tokenPosition.column), callBack:callBack));
    }
    return widgets;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Board(keyRefrences),
          ... _getTokenList()
        ]
    );
  }
}








/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_engine/models/dice_model.dart';
import '../game_engine/models/game_state.dart';
import 'dice.dart';
void main() => runApp(const MyLudo());

class MyLudo extends StatelessWidget {
  const MyLudo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>GameState()),
            ChangeNotifierProvider(create: (context)=>DiceModel()),
          ],
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey keyBar = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      appBar: AppBar(
        key: keyBar,
        title: const Text('Ludo'),
      ),
      body: GamePlay(keyBar,gameState),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: const Dice(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}*/