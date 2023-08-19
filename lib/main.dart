import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo_world_war/screens/main_screens/home_screen.dart';
import 'language/local_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const LudoWorldWar());
}

class LudoWorldWar extends StatefulWidget {
  const LudoWorldWar({super.key});

  @override
  State<LudoWorldWar> createState() => _LudoWorldWarState();
}

class _LudoWorldWarState extends State<LudoWorldWar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      translations: LocalStrings(),
      locale: const Locale('en','US'),
      home: const  LudoHomeScreen()
    );
  }


}

// Link to the ludo on github: https://github.com/Apoorv-cloud/Flutter_Ludo/tree/master
