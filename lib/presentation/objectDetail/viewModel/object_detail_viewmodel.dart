
import 'dart:ffi';

import 'package:http_course/domain/model/models.dart';
import 'package:http_course/domain/usecase/object_details_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/base_view_model.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ObjectDetailsViewModel extends BaseViewModel with ObjectDetailsViewModelInput,ObjectDetailsViewModelOutput {

  final _objectDetailsStreamController = BehaviorSubject<ObjectDetails>();
  final ObjectDetailsUseCase objectDetailsUseCase;

  var detailObject = DetailObject("");


  ObjectDetailsViewModel(this.objectDetailsUseCase);

  
  @override
  void start() {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)); 
    (await objectDetailsUseCase.execute(detailObject.id)).fold(
          (failure) {
        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      }, 
          (objectDetails) async {
        inputState.add(ContentState());
        inputObjectDetails.add(objectDetails); 
      },
    );
  }

  @override
  void dispose() {
    _objectDetailsStreamController.close();
  }
  
  @override
  Sink get inputObjectDetails => _objectDetailsStreamController.sink;
  
  @override
  Stream<ObjectDetails> get outputObjectDetails => _objectDetailsStreamController.stream.map((object) => object);
  
  @override
  setId(String id) {
    if (id.isNotEmpty) {
      //  update register view object
      detailObject = detailObject.copyWith(id: id);
    } else {
      // reset mobileNumber value in register view object
      detailObject = detailObject.copyWith(id: "");
    }
  }


}

abstract class ObjectDetailsViewModelInput {

  setId(String id);
  Sink get inputObjectDetails;
}

abstract class ObjectDetailsViewModelOutput {
  Stream<ObjectDetails> get outputObjectDetails;
}