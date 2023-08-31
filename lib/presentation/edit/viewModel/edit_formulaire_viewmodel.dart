
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:http_course/presentation/base/base_view_model.dart';

import '../../../domain/usecase/edit_object_usescase.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';


class EditFormulaireViewModel extends BaseViewModel with EditFormulaireViewModelInput, EditFormulaireViewModelOutput {
  
  
  final StreamController _idStreamController = StreamController<String>.broadcast();
  final StreamController _nameStreamController = StreamController<String>.broadcast();
  final StreamController _typeStreamController = StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController isObjectEditedSUccessfulyStreamController = StreamController<bool>();

  var editObject = EditObject("","","");

  final EditObjectUseCase _editObjectUseCase;

  EditFormulaireViewModel(this._editObjectUseCase);


  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _idStreamController.close();
    _nameStreamController.close();
    _typeStreamController.close();
    _areAllInputsValidStreamController.close();
    isObjectEditedSUccessfulyStreamController.close();
  }
  
  @override
  Stream<bool> get areAllInputsValid => _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());
  
  bool _areAllInputsValid() {
    return _isIdValid(editObject.id) && _isNameValid(editObject.name) && _isTypeValid(editObject.type);
  }

  @override
  edit() async{
    //inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (
      await _editObjectUseCase.execute(EditUsesCaseInput(editObject.id, editObject.name, editObject.type))).fold(
      (failure) => {
        // left -> failure
        inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message.tr()))
      }, 
      (supportMessage)  {
        // right -> Data (success)
        // content
        inputState.add(SuccessState(supportMessage));

        // navigate the same page
        //isObjectEditedSUccessfulyStreamController.add(true);
        
      }
    );
  }
  
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  
  @override
  Sink get inputId => _idStreamController.sink;
  
  @override
  Sink get inputName => _nameStreamController.sink;
  
  @override
  Sink get inputType => _typeStreamController.sink;
  
  @override
  Stream<bool> get outIsIdValid => _idStreamController.stream.map((id) => _isIdValid(id));

  // TODO to be implemented later
  bool _isIdValid(String id) {
    return true;
  }
  
  @override
  Stream<bool> get outIsNameValid => _nameStreamController.stream.map((name) => _isNameValid(name));

  // TODO to be implemented later
  bool _isNameValid(String name) {
    return true;
  }
  
  @override
  Stream<bool> get outIsTypeValid => _typeStreamController.stream.map((type) => _isTypeValid(type));
  
  // TODO to be implemented later
  bool _isTypeValid(String type) {
    return true;
  }

  @override
  setId(String id) {
    inputId.add(id);
    editObject = editObject.copyWith(id: id);
    inputAreAllInputsValid.add(null);
  }
  
  @override
  setName(String name) {
    inputName.add(name);
    editObject = editObject.copyWith(name: name);
    inputAreAllInputsValid.add(null);
  }
  
  @override
  setType(String type) {
    inputType.add(type);
    editObject = editObject.copyWith(type: type);
    inputAreAllInputsValid.add(null);
  }


}

abstract class EditFormulaireViewModelInput {

  setId(String id);
  setName(String name);
  setType(String type);
  edit();

  Sink get inputId;
  Sink get inputName;
  Sink get inputType;
  Sink get inputAreAllInputsValid;


}

abstract class EditFormulaireViewModelOutput {

  Stream<bool> get outIsIdValid;
  Stream<bool> get outIsNameValid;
  Stream<bool> get outIsTypeValid;
  Stream<bool> get areAllInputsValid;

}
