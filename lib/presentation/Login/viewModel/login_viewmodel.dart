import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:http_course/domain/usecase/login_usecase.dart';
import 'package:http_course/presentation/base/base_view_model.dart';
import 'package:http_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:http_course/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:http_course/presentation/ressources/strings_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/freezed_data_classes.dart';


class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{ 

  final AppPreferences _appPreferences = instance<AppPreferences>();

  final StreamController _userNameStreamController = StreamController<String>.broadcast();  
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController isUserLoggedInSUccessfulyStreamController = StreamController<bool>();

  var loginObject = LoginObject("","");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // inputs 

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSUccessfulyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }
  
  @override
  Sink get inputPassword => _passwordStreamController.sink;
  
  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  

  
  @override
  login() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (
      await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName, loginObject.password))).fold(
      (failure) => {
        // left -> failure
        inputState.add(ErrorState(StateRendererType.popupErrorState, AppStrings.wrongData.tr()/*failure.message.tr()*/))
      }, 
      (data)  {
        // right -> Data (success)
        // content
        inputState.add(ContentState());
        // navigate to main screen
        _appPreferences.saveUserName(data.customer!.name);
        _appPreferences.saveGmail(data.contacts!.email);
        _appPreferences.saveUserId(data.customer!.id);
        isUserLoggedInSUccessfulyStreamController.add(true);
        
      }
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }
  
  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
  }

  // outputs
  
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));
  
  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get areAllInputsValid => _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  bool _isPasswordValid(String password) {
    // TODO set password restriction
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    // TODO set userName restriction
    return userName.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) && _isUserNameValid(loginObject.userName);
  }
  

  


}

abstract class LoginViewModelInputs {

  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;

}

abstract class LoginViewModelOutputs {
  
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get areAllInputsValid;

}