import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http_course/main.dart';
import 'package:http_course/presentation/ressources/assets_manager.dart';
import 'package:http_course/presentation/ressources/color_manager.dart';
import 'package:http_course/presentation/ressources/constants_manager.dart';
import 'package:http_course/presentation/ressources/fonts_manager.dart';
import 'package:http_course/presentation/ressources/routes_manager.dart';
import 'package:http_course/presentation/ressources/styles_manager.dart';
import 'package:http_course/presentation/ressources/values_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../ressources/strings_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(Duration(seconds: AppConstants.splashDelay), _goNext);
  }


  // TODO decommenter le code 
  _goNext() async {
   /*Navigator.pushReplacementNamed(context, RoutesManager.onBoardingTest);*/
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate To main Screen
              Navigator.pushReplacementNamed(context, RoutesManager.mainRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            // navigate to login screen
                            Navigator.pushReplacementNamed(
                                context, RoutesManager.login)
                          }
                        else
                          {
                            // navigate to onBoarding screen
                            Navigator.pushReplacementNamed(
                                context, RoutesManager.onBoardingTest)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      body: Stack(
        children: [
          Center(
            child: Container(
              //width: 100,
              child: Image(image: AssetImage(AssetsManager.splashLogo)),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              child: Text(
                AppStrings.appName.tr(),
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: ColorManager.splashGrey, fontSize: FontSize.s24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
