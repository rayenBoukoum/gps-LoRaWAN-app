import 'dart:async';
import 'package:http_course/presentation/ressources/strings_manager.dart';
import 'package:http_course/presentation/ressources/assets_manager.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:http_course/presentation/base/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs{

  // stream controllers outputs
  final StreamController _streamController =  StreamController<SliderViewObject>();
  
  late final List<SliderObject> _list;

  int _currentIndex = 0;



  // base view model inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // view model start your job
    _list = _getSliderData();
    _postDataToView();
  }
  
  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if(nextIndex == _list.length ){
      nextIndex = 0;
    }
    return nextIndex;
  }
  
  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if(previousIndex == -1 ){
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }
  
  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }
  
  @override
  Sink get inputSliderViewObject => _streamController.sink;
  
  // onBoarding viewModel outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // onBoarding private functions

  // remplir la liste avec les donnee de la vue
  List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1.tr(), AppStrings.onBoardingSubTitle1.tr(), AssetsManager.OnBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2.tr(), AppStrings.onBoardingSubTitle2.tr(), AssetsManager.OnBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle3.tr(), AppStrings.onBoardingSubTitle3.tr(), AssetsManager.OnBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle4.tr(), AppStrings.onBoardingSubTitle4.tr(), AssetsManager.OnBoardingLogo1),
  ];

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }


}

// inputs mean that "orders" that our view model will recieve from view 
abstract class OnBoardingViewModelInputs {

  int goNext(); // when user clicks on right arrow or swipe left

  int goPrevious(); // when user clicks on left arrow or swipe right

  void onPageChanged(int index); 

  // stream controller input (sink)
  Sink get inputSliderViewObject;

}

abstract class OnBoardingViewModelOutputs {
  
  // stream controller output (stream)
  Stream<SliderViewObject> get outputSliderViewObject;

}


