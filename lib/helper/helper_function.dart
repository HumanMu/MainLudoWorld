import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {

  //KEYs
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userLastNameKey = "USERLASTNAMEKEY";
  static String appLanguageKey = "APPLANGUAGEKEY";
  // Saving data to SP

  static Future<bool> saveUserLoginStatus(bool isUserLoggedIn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(userLoggedInKey, isUserLoggedIn);
  }
  static Future<bool> saveAppLanguageSP(List<String> language) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setStringList(appLanguageKey, language);
  }
  static Future<bool> saveUserNameSP(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userNameKey, userName);
  }
  static Future<bool> saveUserLastnameSP(String userLastname) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userLastNameKey, userLastname);
  }
  static Future<bool> saveUserEmailSP(String userEmail) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userEmailKey, userEmail);
  }

  // Getting the data from SP
  static Future <bool?> getUserLoggedInState() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(userLoggedInKey); // If the key exist (means a user is logged in) return true else false
  }
  static Future <List<String>?>? getAppLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(appLanguageKey); // If the key exist (means a user is logged in) return true else false
  }

  static Future <String?> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userNameKey); // If the key exist (means a user is logged in) return true else false
  }
  static Future <String?> getUserLastName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userLastNameKey); // If the key exist (means a user is logged in) return true else false
  }

  static Future <String?> getUserEmail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userEmailKey); // If the key exist (means a user is logged in) return true else false
  }
}