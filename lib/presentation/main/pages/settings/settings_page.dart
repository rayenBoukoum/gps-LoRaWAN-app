import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http_course/app/app_prefs.dart';
import 'package:http_course/data/data_source/local_data_source.dart';
import 'package:http_course/presentation/ressources/color_manager.dart';
import 'package:http_course/presentation/ressources/fonts_manager.dart';
import 'package:http_course/presentation/ressources/routes_manager.dart';

import '../../../../app/di.dart';
import '../../../ressources/language_manager.dart';
import '../../../ressources/strings_manager.dart';
import '../../../ressources/styles_manager.dart';
import '../../../ressources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool langParamOpen = false;

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: Icon(Icons.contact_support_sharp),
            title: Text(AppStrings.contactUs.tr(), style: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14)),
            trailing: Icon(Icons.chevron_right_sharp),
            onTap: (){
              _contactUs();
            },
          ),
            ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                langParamOpen = !langParamOpen;
              });
            },
            leading: Icon(Icons.language_outlined),
            title: Text(AppStrings.changeLang.tr(), style: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14)),
            trailing: langParamOpen ? Icon(Icons.expand_more)  : Icon(Icons.chevron_right_sharp) ,
            children: [
              ListTile(
                title: Text(AppStrings.english.tr()),
                trailing: _getCurrentLang(LanguageType.ENGLISH.getValue()) ? Icon(Icons.check): null,  
                onTap: (){
                  _changeLanguage(LanguageType.ENGLISH.getValue()); 
                },
              ),
               ListTile(
                title: Text(AppStrings.frensh.tr()),
                trailing: _getCurrentLang(LanguageType.FRENSH.getValue()) ? Icon(Icons.check): null,  
                onTap: (){
                  _changeLanguage(LanguageType.FRENSH.getValue()); 
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.insert_invitation),
            title: Text(AppStrings.inviteFrinds.tr(), style: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14)),
            trailing: Icon(Icons.chevron_right_sharp),
            onTap: (){
              _inviteFriends();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(AppStrings.logout.tr(), style: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14)),
            trailing: Icon(Icons.chevron_right_sharp),
            onTap: (){
              _logout();
            },
          ),
        ],
      ),
    );
  }



  _changeLanguage(String lang) {
    _appPreferences.changeAppLanguage(lang);
    Phoenix.rebirth(context);
  }

   bool _getCurrentLang(String lang) {
    return lang == _appPreferences.getLang();
  }

  _contactUs() {
    // TODO to be implemented later 
  }

  _inviteFriends() {
    // TODO to be implemented later 
  }

  _logout(){
    // app prefs make that user logged out
    _appPreferences.logout();
    // clear cache
    _localDataSource.clearCache();
    // navigate to login screen
    Navigator.pushReplacementNamed(context, RoutesManager.login);
  }

}


/*

onTap: (){
              
            },
 */