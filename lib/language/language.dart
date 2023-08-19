import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo_world_war/helper/helper_function.dart';

class CustomLanguage extends StatelessWidget {
  //BuildContext context;
  CustomLanguage({super.key});

  final List locale = [
    {'name': 'english'.tr, 'locale': const Locale('en', 'US')},
    {'name': 'farsi'.tr, 'locale': const Locale('fa', 'AF')},
  ];


  @override
  Widget build(BuildContext context) {
    return languageDialog(context);
  }
  void saveLanguage(String selectedLanguage) async {
    String countryId = selectedLanguage.substring(selectedLanguage.indexOf("_") + 1);
    String languageId = selectedLanguage.substring(0, selectedLanguage.indexOf("_"));
    List<String> language = [languageId, countryId];

    await HelperFunction.saveAppLanguageSP(language);
  }

  updateLanguage(Locale locale){
    saveLanguage(locale.toString());
    Get.back();
    Get.updateLocale(locale);
  }

  languageDialog(BuildContext context){
    showDialog(context: context, builder: (builder) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('choose_language'.tr),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            itemCount: locale.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {updateLanguage(locale[index]['locale']);},
                  child: Text(locale[index]['name'])
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.red,
              );
            },
          ),
        ),
      );
    });
  }
}