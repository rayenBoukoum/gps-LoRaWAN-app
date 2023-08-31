

import 'dart:ui';

import 'package:http_course/presentation/ressources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEW = "PREFS_KEY_ONBOARDING_SCREEN_VIEW";
const String PREFS_KEY_IS_USER_LOGGED_IN= "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_USER_NAME= "PREFS_KEY_USER_NAME";
const String PREFS_KEY_GMAIL= "PREFS_KEY_GMAIL";
const String PREFS_KEY_USER_ID= "PREFS_KEY_USER_ID";

class AppPreferences {

  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if(language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.ENGLISH.getValue();
    }
  }

  getLang() {
    return _sharedPreferences.getString(PREFS_KEY_LANG);
  }


  // on boarding
  Future<void> setOnBoardingScreenViewed() async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEW,true);
  }

    Future<bool> isOnBoardingScreenViewed() async{
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEW) ?? false;
  }

  // login
    Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN,true);
  }

    Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

    // userName
    Future<void> saveUserName(String userName) async{
    _sharedPreferences.setString(PREFS_KEY_USER_NAME,userName);
  }

    Future<String> getUserName() async{
    return _sharedPreferences.getString(PREFS_KEY_USER_NAME) ?? "";
  }

  // gmail
  Future<void> saveGmail(String gmail) async{
    _sharedPreferences.setString(PREFS_KEY_GMAIL,gmail);
  }

  Future<String> getGmail() async{
    return _sharedPreferences.getString(PREFS_KEY_GMAIL) ?? "";
  }

  // ID
  Future<void> saveUserId(String userId) async{
    _sharedPreferences.setString(PREFS_KEY_USER_ID,userId);
  }

  Future<String> getUserId() async{
    return _sharedPreferences.getString(PREFS_KEY_USER_ID) ?? "";
  }



  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }

  Future<void> changeAppLanguage(String lang) async{

      _sharedPreferences.setString(PREFS_KEY_LANG, lang);

  }

    Future<Locale> getLocal() async{
    String currentLang = await getAppLanguage();
    if(currentLang == LanguageType.FRENSH.getValue()) {
      return FRENSH_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }


}