import 'dart:async';
import 'dart:ffi';

import 'package:http_course/domain/usecase/delete_object_usesCase.dart';
import 'package:http_course/domain/usecase/map_usescase.dart';
import 'package:rxdart/rxdart.dart';

import 'package:http_course/domain/model/models.dart';
import 'package:http_course/presentation/base/base_view_model.dart';

import '../../../../../app/Constants.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../data/data_source/local_data_source.dart';
import '../../../domain/usecase/object_editable_data_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class EditViewModel extends BaseViewModel with EditViewModelInput,EditViewModelOutput { 

  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  final  _editStreamController = BehaviorSubject<List<OneObject>>();


  ObjectEditableDataUseCase _objectEditableDataUseCase;
  DeleteObjectUseCase _deleteObjectUseCase;

  EditViewModel(this._objectEditableDataUseCase, this._deleteObjectUseCase); 

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
   await  _getUserId();
       print("------------------------------ccccccccccccc------------------------------");
    print(id);
    print("------------------------------ccccccccccccc------------------------------");
    _getMapData();
  }

  _getMapData() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _objectEditableDataUseCase.execute(id)).fold( 
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
      inputMap.add(homeObject.objects);
      // navigate to main screen
    });
  }

  @override
  void dispose() {
  _editStreamController.close();
    super.dispose();
  }
  
  @override
  Sink get inputMap => _editStreamController.sink;
  
  @override
  Stream<List<OneObject>> get outputMap => _editStreamController.stream.map((oneObject) => oneObject);
  

  @override
  deleteObject(String id) async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _deleteObjectUseCase.execute(id)).fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (supportMessage) {
      inputState.add(SuccessState(supportMessage));
      _localDataSource.clearCache();
      
    });
  }
  


}

abstract class EditViewModelInput {


  Sink get inputMap;
  deleteObject(String id);

}

abstract class EditViewModelOutput {
  Stream<List<OneObject>> get outputMap;
}