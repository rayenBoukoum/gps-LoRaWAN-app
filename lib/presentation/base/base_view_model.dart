import 'dart:async';

import 'package:http_course/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends baseViewModelInputs with baseViewModelOutputs{
  // shared variables and functions that will be used through any view model.
  final StreamController _inputStreamController = BehaviorSubject<FlowState>();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);

}

// view model input
abstract class baseViewModelInputs{

  void start(); // start view model job 
  void dispose(); // will be called when view model dies

  Sink get inputState;
}

// view model output
abstract class baseViewModelOutputs{
  Stream<FlowState> get outputState;
}