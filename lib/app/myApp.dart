import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http_course/app/app_prefs.dart';
import 'package:http_course/presentation/ressources/color_manager.dart';
import 'package:http_course/presentation/ressources/routes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  
  MyApp._internal();
  static final MyApp _instance  = MyApp._internal();

  factory MyApp() =>  _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((locale) => {context.setLocale(locale)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: RoutesManager.splashRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}