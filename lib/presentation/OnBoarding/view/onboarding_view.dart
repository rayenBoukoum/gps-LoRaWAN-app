import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http_course/app/app_prefs.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:http_course/presentation/OnBoarding/viewModel/onboarding_viewmodel.dart';
import 'package:http_course/presentation/ressources/color_manager.dart';
import 'package:http_course/presentation/ressources/constants_manager.dart';
import 'package:http_course/presentation/ressources/fonts_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:http_course/presentation/ressources/styles_manager.dart';

import '../../../app/di.dart';
import '../../ressources/routes_manager.dart';
import '../../ressources/strings_manager.dart';
import '../../ressources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  // page view controller
  final PageController _pageController = PageController();
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
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot){
        return _getContentWidget(snapshot.data);
      },
      );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
      if(sliderViewObject == null) {
        return Container();
      } else {
      return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numberOfSlides,
        onPageChanged: (index) {
          _viewModel.onPageChanged(index);
        },
        itemBuilder: (context, index){
          return OnBoardingPage(sliderViewObject.sliderObject);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.primary,
        //height: AppSize.s100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, RoutesManager.login);
                },
                child: Text(
                  AppStrings.skip.tr(),
                  textAlign: TextAlign.end,
                  style: getMediumStyle(color: ColorManager.orange, fontSize: FontSize.s16),
                  ),
              ),
            ),
            // widget indicator arrows
            _getBottomSheetWidget(sliderViewObject),
          ],
        ),
      ),
    );
}
    }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
      return Container(
        color: ColorManager.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // left arrow
            Padding(
              padding: EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: Icon(Icons.chevron_left_sharp),
                ),
                onTap: (){
                  // go to previous slide
                  _pageController.animateToPage(_viewModel.goPrevious(), duration: const Duration(milliseconds: AppConstants.sliderAnimationTime), curve: Curves.bounceInOut);
                },
              ),
            ),

            // circle indicator
            Row(
              children: [
                for(int i=0; i<sliderViewObject.numberOfSlides; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: _getProperCircle(i,sliderViewObject.currentIndex),
                  ),
                
              ],
            ),
            // right arrow
            Padding(
              padding: EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: Icon(Icons.chevron_right_sharp),
                ),
                onTap: (){
                  // go to next slide
                  _pageController.animateToPage(_viewModel.goNext(), duration: const Duration(milliseconds: AppConstants.sliderAnimationTime), curve: Curves.bounceInOut);

                },
              ),
            ),
            
          ],
        ),
      );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if(index == currentIndex) {
      return Icon(Icons.brightness_1);
    }
    return Icon(Icons.brightness_1_outlined);
  }
  
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

}

class OnBoardingPage extends StatelessWidget {

  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.s20,),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title, 
            textAlign: TextAlign.center,
            style: getSemiBoldStyle(fontSize: FontSize.s16, color: ColorManager.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle, 
            textAlign: TextAlign.center,
            style: getRegularStyle(fontSize: FontSize.s14, color: ColorManager.grey),
          ),
        ),
        SizedBox(height: AppSize.s60,),
        Image(image: AssetImage(_sliderObject.image)),
      ],
    );
  }
}



            
