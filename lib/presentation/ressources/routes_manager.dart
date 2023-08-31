import 'package:flutter/material.dart';
import 'package:http_course/app/di.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:http_course/presentation/Delete/view/edit_view.dart';
import 'package:http_course/presentation/Login/view/login_view.dart';
import 'package:http_course/presentation/OnBoarding/view/onboarding_view.dart';
import 'package:http_course/presentation/edit/view/edit_formulaire_view.dart';
import 'package:http_course/presentation/main/main_view.dart';
import 'package:http_course/presentation/main/pages/search/view/search_page.dart';
import 'package:http_course/presentation/objectDetail/view/object_detail_view.dart';
import 'package:http_course/presentation/register/view/register_view.dart';
import 'package:http_course/presentation/ressources/strings_manager.dart';
import 'package:http_course/presentation/splash/spash_view.dart';

import '../OnBoarding/view/test.dart';
import '../addObject/view/add_object_view.dart';
import '../forgetPassword/view/forget_password_view.dart';
import 'package:easy_localization/easy_localization.dart';

import '../oneObjectMap/one_object_map_view.dart';
import '../register/view/register.dart';



class RoutesManager {

  static const String mainRoute = "/main";
  static const String splashRoute = "/";
  static const String onBoarding= "/onBoarding";
  static const String onBoardingTest= "/onBoardingTest";
  static const String login = "/login";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String registerRoute = "/register";
  static const String objectDetailsRoute = "/objectDetail";
  static const String oneObjectMapRoute = "/oneObjectMap";
  static const String editRoute = "/editRoute";
  static const String editObjectRoute = "/editObjectRoute";
  static const String addObjectRoute = "/addObjectRoute";
  
}

class RouteGenerator {

  static Route<dynamic> getRoute(RouteSettings settings) { 
    switch (settings.name) {
      case  RoutesManager.splashRoute :
        return MaterialPageRoute(builder: (_) => const SplashView());
      case  RoutesManager.objectDetailsRoute :
        final args = settings.arguments as Map<String, String>;
        initObjectDetailsModule();
        return MaterialPageRoute(builder: (_) =>  ObjectDetailsView(id: args['id']!,));
      case  RoutesManager.onBoarding :
        return MaterialPageRoute(builder: (_) => const OnBoardingView()); 
      case  RoutesManager.onBoardingTest :
        return MaterialPageRoute(builder: (_) => const OnBoardingViewTest()); 
      case  RoutesManager.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case  RoutesManager.addObjectRoute:
        initAddObjectModule();
        return MaterialPageRoute(builder: (_) => const AddObjectView());
      case  RoutesManager.forgetPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case  RoutesManager.editRoute:
        initObjectEditableDataModule();
        return MaterialPageRoute(builder: (_) => const EditView());
      case  RoutesManager.editObjectRoute:
      final args = settings.arguments as Map<String, String>;
        initEditObjectModule();
        return MaterialPageRoute(builder: (_) =>  EditFormView(id: args['id']!, name: args['name']!, type: args['type']!,));
      case  RoutesManager.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const /*RegisterView()*/Register());// TODO to change decomment RegisterView() and change ui with Register()
      case  RoutesManager.oneObjectMapRoute:
        final args = settings.arguments as Map<String, double>; 
        return MaterialPageRoute(builder: (_) =>  OneObjectMapView(latitude: args['latitude']!,longitude: args['longitude']!,));
      case  RoutesManager.mainRoute:
        //initHomeModule();// TODO to change to initMapModule
        initMapModule();
        initSearchModule();
        initDashModule();
        //initMapModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(builder: (_) => 
    Scaffold(
      appBar: AppBar(
        title:   Text(AppStrings.noRouteFound.tr()),
      ),
    )
    );
  }
}