import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/navigation.dart';
import 'play_screen.dart';

class LudoHomeScreen extends StatefulWidget {
  final String? title;
  const LudoHomeScreen({ Key? key, this.title}) : super(key: key);
  @override
  State<LudoHomeScreen> createState() => _LudoHomeScreenState();
}

class _LudoHomeScreenState extends State<LudoHomeScreen> {
  GlobalKey keyBar = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.red,
        key: keyBar,
        centerTitle: true,
        title: Text('ludo_world_war'.tr),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  gameTypeContainer("Two players", 2),
                  const SizedBox(width: 12),
                  gameTypeContainer("Three players", 3),
                ]
            ),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  gameTypeContainer("Four players", 4),
                  const SizedBox(width: 12),
                  gameTypeContainer("Custom number of players", 6),
                ]
            )
          ],
        )
    );
  }

  Widget gameTypeContainer(String title, int numberPlayers) {
    return GestureDetector(
      onTap: () =>  navigateToAnotherScreen(context,
        GamePicker(title: "$numberPlayers players",),
      ),
      child: Container(
        height: 80,   width: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.red, spreadRadius: 3),
          ],
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 13)
        ),
      ),
    );
  }
}