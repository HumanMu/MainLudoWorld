import 'package:get/get.dart';

class LocalStrings extends Translations {

  @override
  Map<String, Map<String, String>> get keys =>
      {
        'en_US': {
          //appName
          'appName': 'Khorasan',

          // Games
          'games': 'Games',
          'games_list': 'Games list',
          'ludo_world_war': 'Ludo World War',
        },
        'fa_AF' : {
          //appName
          'appName': 'Khorasan',

          // Games
          'games': 'Games',
          'games_list': 'Games list',
          'ludo_world_war': 'جنگ جهانی لودو',
        }
      };
}