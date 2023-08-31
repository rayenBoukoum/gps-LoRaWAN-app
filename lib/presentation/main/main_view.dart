import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http_course/presentation/main/pages/map/view/map_page.dart';
import 'package:http_course/presentation/main/pages/notifications/view/notification_page.dart';
import 'package:http_course/presentation/main/pages/search/view/search_page.dart';
import 'package:http_course/presentation/main/pages/settings/settings_page.dart';
import 'package:http_course/presentation/main/pages/settings/settings_view.dart';
import 'package:http_course/presentation/ressources/fonts_manager.dart';

import '../ressources/color_manager.dart';
import '../ressources/routes_manager.dart';
import '../ressources/strings_manager.dart';
import '../ressources/styles_manager.dart';
import '../ressources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  //const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> pages = [
    SearchPage(),
    MapPage(),
    NotificationPage(),
    SettingsView()
  ];

  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr(),
  ];

  var _title = AppStrings.home.tr();

  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  Visibility(
    visible: _currentIndex == 0,
    child: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutesManager.addObjectRoute);
      },
      child: Icon(Icons.add),
      backgroundColor: ColorManager.primary,
    ),
  ),
      /*appBar: (_currentIndex != 1 && _currentIndex != 2) ? AppBar(
        title: Text(
          _title,
          style: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16),
        ),
      ) : null,*/
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        color : ColorManager.primary,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10,),
        child: GNav(
          backgroundColor: ColorManager.primary,
          color:Colors.white ,
          activeColor: ColorManager.primary,
          tabBackgroundColor: Colors.white,
          gap: 8,
          padding: EdgeInsets.all(8),
          onTabChange: onTap,
          tabs:  [
        GButton(
          icon: Icons.home_outlined,
          text: AppStrings.home.tr(),
        ),
        GButton(
          icon: Icons.map_outlined,
          text: AppStrings.map.tr(),
        ),
        GButton(
          icon: Icons.dashboard_customize_outlined,
          text: AppStrings.dashboard.tr(),
        ),
        GButton(
          icon: Icons.settings_outlined,
          text:  AppStrings.settings.tr(),
        ),
        ]
        ),
      ),
      )
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}





