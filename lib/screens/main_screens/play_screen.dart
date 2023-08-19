import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game_engine/models/dice_model.dart';
import '../../game_engine/models/game_state.dart';
import '../../widgets/dice.dart';
import '../../widgets/game_play.dart';
void main(){
  runApp(
    const GamePicker(title: 'Ludo',),
  );
}

class GamePicker extends StatelessWidget {
  final String title;
  const GamePicker({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GameState>(create: (_) => GameState()),
          ChangeNotifierProvider<DiceModel>(create: (_) => DiceModel()),
        ],
        builder: (context, child) {
          return GamePickerState(title: title);
        }
      );
  }
}

class GamePickerState extends StatefulWidget {
  final String title;
  const GamePickerState({ Key? key, required this.title}) : super(key: key);
  @override
  State<GamePickerState> createState() => _GamePickerState();
}

class _GamePickerState extends State<GamePickerState> {
  GlobalKey keyBar = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.red,
        key: keyBar,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:MaterialApp(
        debugShowCheckedModeBanner: false,
          home: GamePlay(keyBar, gameState)
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        shape: const CircularNotchedRectangle(),
        child: Container( height: 50.0 ),
      ),
      floatingActionButton: const DiceWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}