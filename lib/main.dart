import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http_course/app/di.dart';
import 'package:http_course/presentation/ressources/language_manager.dart';
import 'app/myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      child: Phoenix(child: MyApp()) ,
      supportedLocales: const [FRENSH_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALIZATION));
}
