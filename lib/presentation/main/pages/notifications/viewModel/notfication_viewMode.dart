import 'dart:async';
import 'dart:ffi';

import 'package:http_course/domain/usecase/map_usecase2.dart';
import 'package:rxdart/rxdart.dart';

import 'package:http_course/domain/model/models.dart';
import 'package:http_course/presentation/base/base_view_model.dart';

import '../../../../../app/Constants.dart';
import '../../../../../app/app_prefs.dart';
import '../../../../../app/di.dart';
import '../../../../../domain/usecase/dash_usescase.dart';
import '../../../../common/freezed_data_classes.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class NotificationViewModel extends BaseViewModel with DashViewModelInput,DashViewModelOutput {


  final  _dashStreamController = BehaviorSubject<List<OneObject>>();

  DashUseCase _dashUseCase;

  var sortableObject = SortableObject(false,false,false,"");

  NotificationViewModel(this._dashUseCase);

  
  final AppPreferences _appPreferences = instance<AppPreferences>();

  String id = "";

  Future<void> _getUserId() async {
    _appPreferences.getUserId().then((value) => {  
       if (value != null)
            {
                id = value, 
            }
}).catchError((e) {
  print(e);
});
  }




  @override
  void start() async{
    await _getUserId();
    print("------------------------------ccccccccccccc------------------------------");
    print(id);
    print("------------------------------ccccccccccccc------------------------------");
    _getMapData();
  }

  _getMapData() async{
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _dashUseCase.execute(id)).fold( 
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
      inputDash.add(homeObject.objects);
      // navigate to main screen
    });
  }

  @override
  void dispose() {
  _dashStreamController.close();
    super.dispose();
  }
  
  @override
  Sink get inputDash => _dashStreamController.sink;
  
  @override
  Stream<List<OneObject>> get outputDash => _dashStreamController.stream.map((oneObject) => oneObject);
  

  

  
  @override
  setCarTypeFilterOn() {
    sortableObject = sortableObject.copyWith(getListOfCars: true);
  }
  
  @override
  setKidTypeFilterOn() {
    sortableObject = sortableObject.copyWith(getListOfKids: true);
  }
  
  @override
  setPetTypeFilterOn() {
    sortableObject = sortableObject.copyWith(getListOfPets: true);
  }
  
  @override
  setSearchWord(String word) {
    sortableObject = sortableObject.copyWith(searchWithWord: word);
  }
  
  @override
  List<OneObject> getFinalFiltredData(List<OneObject> list) {

    List<OneObject> filteredList = list;

    if(sortableObject.getListOfCars == true) {
      filteredList = getDataWithType(filteredList,ItemsType.carObject);
    }
    if(sortableObject.getListOfKids == true) {
      filteredList = getDataWithType(filteredList,ItemsType.kidObject);
    }
    if(sortableObject.getListOfPets == true) {
      filteredList = getDataWithType(filteredList,ItemsType.petObject);
    }

    if(sortableObject.searchWithWord != "") {
      filteredList = searchWord(filteredList, sortableObject.searchWithWord);
    }

    return filteredList;
    
  }

  List<OneObject> getDataWithType(List<OneObject> items ,String type) {
    return items.where((item) => item.type == type).toList();
  }

  List<OneObject> searchWord(List<OneObject> objects, String query) {
    List<OneObject> filteredList = [];
    if (query.isNotEmpty) {
      filteredList = objects
          .where((object) =>
              object.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredList = objects;
    }
    return filteredList;
  }
  
  @override
  unsetAll() {
    sortableObject = sortableObject.copyWith(getListOfPets: false ,getListOfCars: false ,getListOfKids: false);
  }




  



}

abstract class DashViewModelInput {

   Sink get inputDash;

  setCarTypeFilterOn();
  setKidTypeFilterOn();
  setPetTypeFilterOn();
  unsetAll();
  setSearchWord(String word);

   List<OneObject> getFinalFiltredData(List<OneObject> list);


}

abstract class DashViewModelOutput {
  Stream<List<OneObject>> get outputDash;
}