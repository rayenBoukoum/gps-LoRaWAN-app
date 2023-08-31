import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:http_course/domain/usecase/login_usecase.dart';
import 'package:http_course/presentation/base/base_view_model.dart';
import 'package:http_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:http_course/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../domain/usecase/add_object_usescase.dart';
import '../../common/freezed_data_classes.dart';


class AddObjectViewModel extends BaseViewModel with AddObjectViewModelInputs, AddObjectViewModelOutputs{ 

  final AppPreferences _appPreferences = instance<AppPreferences>();

  final StreamController _nameStreamController = StreamController<String>.broadcast();
  final StreamController _typeStreamController = StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController = StreamController<void>.broadcast();

  var addObject = AddObject("","");

  final AddObjectUseCase _addObjectUseCase;

  AddObjectViewModel(this._addObjectUseCase);


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

  // inputs 

  @override
  void dispose() {
    super.dispose();
    _nameStreamController.close();
    _typeStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() async{
    await _getUserId();
    print("------------------------------ccccccccccccc------------------------------");
    print(id);
    print("------------------------------ccccccccccccc------------------------------");
    // view model should tell view please show content state
    inputState.add(ContentState());
  }
  

  

  
  @override
  addNewObject() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (
      await _addObjectUseCase.execute(AddUseCaseInput(id, addObject.name, addObject.type))).fold(
      (failure) => {
        // left -> failure
        inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message.tr()))
      }, 
      (supportMessage)  {
        // right -> Data (success)
        // content
      inputState.add(SuccessState(supportMessage));
      //_localDataSource.clearCache();
        
      }
    );
  }

  @override
  setName(String name) {
    inputName.add(name);
    addObject = addObject.copyWith(name: name);
    inputAreAllInputsValid.add(null);
  }
  
  @override
  setType(String type) {
    inputType.add(type);
    addObject = addObject.copyWith(type: type);
    inputAreAllInputsValid.add(null);
  }

  // outputs
  


  @override
  Stream<bool> get areAllInputsValid => _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  bool _isTypeValid(String type) {
    // TODO set password restriction
    return type.isNotEmpty;
  }

  bool _isNameValid(String name) {
    // TODO set userName restriction
    return name.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isTypeValid(addObject.name) && _isNameValid(addObject.type);
  }
  
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  
  @override
  // TODO: implement inputName
  Sink get inputName => _nameStreamController.sink;
  
  @override
  Sink get inputType => _typeStreamController.sink;

  
  @override
  Stream<bool> get outIsNameValid => _nameStreamController.stream.map((name) => _isNameValid(name));
  
  @override
  Stream<bool> get outIsTypeValid => _typeStreamController.stream.map((type) => _isTypeValid(type));
  

  


}

abstract class AddObjectViewModelInputs {

  setName(String name);
  setType(String type);
  addNewObject();

  Sink get inputName;
  Sink get inputType;
  Sink get inputAreAllInputsValid;

}

abstract class AddObjectViewModelOutputs {
  
  Stream<bool> get outIsNameValid;
  Stream<bool> get outIsTypeValid;
  Stream<bool> get areAllInputsValid;

}