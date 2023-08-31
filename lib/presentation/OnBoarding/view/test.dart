import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_course/presentation/ressources/styles_manager.dart';
import 'package:http_course/presentation/ressources/fonts_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../domain/model/models.dart';
import '../../ressources/assets_manager.dart';
import '../../ressources/color_manager.dart';
import '../../ressources/constants_manager.dart';
import '../../ressources/routes_manager.dart';
import '../../ressources/size_config.dart';
import '../../ressources/strings_manager.dart';
import '../../ressources/values_manager.dart';
import '../viewModel/onboarding_viewmodel.dart';

class OnBoardingViewTest extends StatefulWidget {
  const OnBoardingViewTest({super.key});

  @override
  State<OnBoardingViewTest> createState() => _OnBoardingViewTestState();
}

class _OnBoardingViewTestState extends State<OnBoardingViewTest> {

  // instance of onBordingViewModel
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  // instance of App preference
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Fond bleu
          Container(
            decoration: BoxDecoration(
              color: ColorManager.white,
            ),
          ),
          // Texte Welcome en haut
          Positioned(
            top: 80,
            left: 24,
            child: Text(
              "Welcome",
              style: getBoldStyle(color: ColorManager.primary,fontSize: 42),
            ),
          ),

          
          // Description de l'application
          Positioned(
            top: 180,
            left: 24,
            right: 24,
            //bottom: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.onBordingText1.tr(),
                  style: getSemiBoldStyle(color: ColorManager.black,fontSize: 25),
                ),
                SizedBox(height: 20),
                Text(
                  AppStrings.onBordingText2.tr(),
                  style: getLightStyle(color :ColorManager.black,fontSize: 14),
                ),
              ],
            ),
          ), 
          // Bouton Get Started 
          Positioned(
            left: 20,
            right: 20,
            bottom: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorManager.primary,
                minimumSize: Size(double.infinity, 50),
              ),  
              onPressed: () {
                Navigator.pushReplacementNamed(context, RoutesManager.login);
              }, 
              child: Text("Get Started"),
            ),
          ),
        ],
      ),
    );
    
  }

}



