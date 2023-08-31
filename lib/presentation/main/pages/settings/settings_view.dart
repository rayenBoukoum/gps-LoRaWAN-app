import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../data/data_source/local_data_source.dart';
import '../../../ressources/color_manager.dart';
import '../../../ressources/fonts_manager.dart';
import '../../../ressources/language_manager.dart';
import '../../../ressources/routes_manager.dart';
import '../../../ressources/strings_manager.dart';
import '../../../ressources/styles_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  bool langParamOpen = false;
  String userName="";
  String gmail = "";
  
  bool isClear = true;
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userVerifyPasswordController = TextEditingController();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>(); 

  Future<void> _getUserName() async {
    _appPreferences.getUserName().then((value) => {
      if(value != null){
        setState(() {
                userName = value;
        }),
      }
    });
  }

  Future<void> _getGmail() async {
    _appPreferences.getGmail().then((value) => {
      if(value != null){
        setState(() {
                gmail = value;
        }),
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserName();
    _getGmail();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(
            right: 24.0,
            left: 24.0,
            top: 10,
          ),
          physics: BouncingScrollPhysics(),
          children: [
            //SizedBox(height: 35,),
            userTile(),
            divider(),
            colorTiles(),
            divider(),
            bwTiles(),
          ],
        ),
      ),
    );
  }

  Widget userTile() {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Color(0xffa4aaad),
        backgroundImage: NetworkImage("https://png.pngtree.com/png-vector/20220817/ourmid/pngtree-cartoon-man-avatar-vector-ilustration-png-image_6111064.png"
            /*"https://i.pinimg.com/originals/ae/ec/c2/aeecc22a67dac7987a80ac0724658493.jpg"*/),
      ),
      title: Text(
        userName,
        style: getBoldStyle(
          fontSize: 16,
          color: Color(0xff1b2028),
        ),
      ),
      subtitle: Text(
        gmail,
        style: getRegularStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 92, 93, 94),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 15,),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        colorTile(Icons.person_outline, Colors.deepPurple, AppStrings.editPersonalData.tr()),
        colorTile(Icons.password, Colors.blue, AppStrings.changePassword.tr()/*, isExpanded: true, children: [
          SizedBox(
                              height: 10.0,
                            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 2.0,
                              ),
                              child: Text(
                                AppStrings.password.tr(),
                                style: getRegularStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.s16),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            TextFormField(
                              obscureText: isClear,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _userPasswordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  onPressed: (){
                                    setState(() {
                                      isClear = !isClear;
                                    });
                                  }, 
                                  icon: isClear ? Icon(Icons.visibility_off)  : Icon(Icons.visibility),
                                  ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                hintText: AppStrings.enterPassword.tr(),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorManager.red),
                                ),
                                hintStyle: getMediumStyle(
                                    color: ColorManager.splashGrey,
                                    fontSize: FontSize.s16),
                                //labelText: AppStrings.password.tr(),
                                errorStyle: TextStyle(color: ColorManager.red,),
                                
                              ),
                            ),
                          ],
                        ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 2.0,
                              ),
                              child: Text(
                                "Verify Password",
                                style: getRegularStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.s16),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            TextFormField(
                              obscureText: isClear,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _userVerifyPasswordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  onPressed: (){
                                    setState(() {
                                      isClear = !isClear;
                                    });
                                  }, 
                                  icon: isClear ? Icon(Icons.visibility_off)  : Icon(Icons.visibility),
                                  ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                hintText: "Verify Password",
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorManager.red),
                                ),
                                hintStyle: getMediumStyle(
                                    color: ColorManager.splashGrey,
                                    fontSize: FontSize.s16),
                                //labelText: AppStrings.password.tr(),
                                errorStyle: TextStyle(color: ColorManager.red,),
                                
                              ),
                            ),
                          ],
                        ),
          ),
          SizedBox(
                              height: 10.0,
                            ),
        ]*/),
        colorTile(Icons.language_outlined, Colors.orange, AppStrings.changeLang.tr(),isExpanded: true,children: [
          Padding(
            padding: const EdgeInsets.only(left:6),
            child: ListTile(
                  title: Text(AppStrings.english.tr(),style:getRegularStyle(
          fontSize: 14,
          color: Color(0xff1b2028),
        ),),
                  leading: _getCurrentLang(LanguageType.ENGLISH.getValue()) ? Icon(Icons.check,size:  25,): Icon(Icons.check,color: Colors.transparent,),  
                  onTap: (){
                    _changeLanguage(LanguageType.ENGLISH.getValue()); 
                  },
                ),
          ),
               Padding(
                 padding: const EdgeInsets.only(left: 6,),
                 child: ListTile(
                  title: Text(AppStrings.frensh.tr(), style:getRegularStyle(
          fontSize: 14,
          color: Color(0xff1b2028),
        ),),
                  leading: _getCurrentLang(LanguageType.FRENSH.getValue()) ? Icon(Icons.check,size:   25,): Icon(Icons.check,color: Colors.transparent,),  
                  onTap: (){
                    _changeLanguage(LanguageType.FRENSH.getValue()); 
                  },
                             ),
               ),
        ],),
        colorTile(Icons.logout, Colors.pink, AppStrings.logout.tr() , onTap: () {
          _logout();
        },),
      ],
    ); 
  } 

  Widget bwTiles() {
    return Column(
      children: [
        bwTile(Icons.info_outline,"FAQs"),
        bwTile(Icons.border_color_outlined,"HandBook"),
        bwTile(Icons.textsms_outlined,"Community"),
      ],
    ); 
  }

  Widget bwTile(IconData icon, String text) {
    return colorTile(icon, Colors.black,text , blackAndWhite: true);
  }

  Widget colorTile(IconData icon, Color color, String text, {bool isExpanded = false , bool blackAndWhite = false, List<Widget> children = const <Widget>[] ,void Function()? onTap,}) {
    if(isExpanded) {
      return ExpansionTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent)
        ),
        onExpansionChanged: (value) {
              setState(() {
                langParamOpen = !langParamOpen;
              });
            },
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: blackAndWhite ? Color(0xfff3f4fe) : color.withOpacity(0.09),
        ),
        child: Icon(icon,color: color,),
      ),
      title: Text(
      text,
      style: getMediumStyle(
          fontSize: 16,
          color: Color(0xff1b2028),
        ),
    ),
      trailing:  langParamOpen ? Icon(Icons.arrow_forward_ios, color: Colors.black, size:20,): Icon(Icons.arrow_forward_ios, color: Colors.black, size:20,),
      children: children,
    );
    } else {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: blackAndWhite ? Color(0xfff3f4fe) : color.withOpacity(0.09),
        ),
        child: Icon(icon,color: color,),
      ),
      title: Text(
      text,
      style: getMediumStyle(
          fontSize: 16,
          color: Color(0xff1b2028), 
        ),
    ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size:20,),
    );
    }

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
