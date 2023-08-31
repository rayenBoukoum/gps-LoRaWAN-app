import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/Constants.dart';
import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../ressources/color_manager.dart';
import '../../ressources/fonts_manager.dart';
import '../../ressources/routes_manager.dart';
import '../../ressources/strings_manager.dart';
import '../../ressources/styles_manager.dart';
import '../../ressources/values_manager.dart';
import '../viewModel/register_viewmodel.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  bool isClear = true;

  _bind() {
    _viewModel.start();
    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });

    _viewModel.isUserRegisteredInSUccessfulyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          // TODO navigate to login view and fill password and email of the registred person
          Navigator.of(context).pushReplacementNamed(RoutesManager.login);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: AppPadding.p16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.hello.tr(),
                      style: getSemiBoldStyle(
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                    
                    AutoSizeText(
                      AppStrings.registerToGetStarted.tr(),
                      style: getMediumStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(children: [
                  Expanded(child: AutoSizeText(AppStrings.alreadyHaveAccount.tr(),
                    style: getRegularStyle(
                        color: Colors.black, fontSize: FontSize.s16), maxLines: 1,)),
                  
                  /*Text(
                    AppStrings.alreadyHaveAccount.tr(),
                    style: getRegularStyle(
                        color: Colors.black, fontSize: FontSize.s16),
                  ),*/
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesManager.login);
                    },
                    child: Expanded(child: AutoSizeText(AppStrings.login.tr(),
                      style: getMediumStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16), maxLines: 1,)),
                  ),
                ]),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p24,
                  right: AppPadding.p24,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                            ),
                            child: Text(
                              AppStrings.username.tr(),
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: FontSize.s16),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameEditingController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                hintStyle: getMediumStyle(
                                    color: ColorManager.splashGrey,
                                    fontSize: FontSize.s16),
                                hintText: AppStrings.username.tr(),
                                errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorManager.red),
                              ),
                                //labelText: AppStrings.username.tr(),
                                errorStyle: TextStyle(
                                  color: ColorManager.red,
                                ),
                                errorText: snapshot.data),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p24,
                  right: AppPadding.p24,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                            ),
                            child: Text(
                              AppStrings.emailHint.tr(),
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: FontSize.s16),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailEditingController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                hintText: AppStrings.exempleMail.tr(),
                                errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorManager.red),
                              ),
                                hintStyle: getMediumStyle(
                                    color: ColorManager.splashGrey,
                                    fontSize: FontSize.s16),
                                errorStyle: TextStyle(
                                  color: ColorManager.red,
                                ),
                                //labelText: AppStrings.emailHint.tr(),
                                errorText: snapshot.data),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p24,
                  right: AppPadding.p24,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorMobileNumber,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                            ),
                            child: Text(
                              AppStrings.mobileNumber.tr(),
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: FontSize.s16),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _mobileNumberEditingController,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  height: 16,
                                  child: CountryCodePicker(
                                    onChanged: (country) {
                                      // update view model with code
                                      _viewModel.setCountryCode(
                                          country.dialCode ?? Constants.token);
                                    },
                                    initialSelection: '+216',
                                    favorite: const ['+216', 'FR', "+966"],
                                    // optional. Shows only country name and flag
                                    showCountryOnly: true,
                                    hideMainText: true,
                                    // optional. Shows only country name and flag when popup is closed.
                                    showOnlyCountryWhenClosed: true,
                                  ),
                                ),
                                hintText: AppStrings.mobileNumber.tr(),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorManager.red),
                              ),
                                hintStyle: getMediumStyle(
                                    color: ColorManager.splashGrey,
                                    fontSize: FontSize.s16),
                                errorStyle: TextStyle(
                                  color: ColorManager.red,
                                ),
                                //labelText: AppStrings.mobileNumber.tr(),
                                errorText: snapshot.data),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p24,
                  right: AppPadding.p24,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 2.0,
                                ),
                                child: Text(
                                  AppStrings.password.tr(),
                                  style: getRegularStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.s16),
                                ),
                              ),
                              getIndicator(_passwordEditingController.text),
                            ],
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            obscureText: isClear,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordEditingController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  onPressed: () {
                                    setState(() {
                                      isClear = !isClear;
                                      //print(_passwordEditingController.text);
                                    });
                                  },
                                  icon: isClear
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                hintText: AppStrings.enterPassword.tr(),
                                errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorManager.red),
                              ),
                                hintStyle: getMediumStyle(
                                    color: ColorManager.splashGrey,
                                    fontSize: FontSize.s16),
                                errorStyle: TextStyle(
                                  color: ColorManager.red,
                                ),
                                //labelText: AppStrings.password.tr(),
                                errorText: snapshot.data),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p24, right: AppPadding.p24),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s48,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.register();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          child: Text(
                            AppStrings.register.tr(),
                            style: getBoldStyle(
                                color: Colors.white, fontSize: FontSize.s16),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                            height: 24.0,
                          ),
            ]),
          ),
          
        ),
      ),
    );
  }

  int getLevel(String password) {
    int score = 0;

    if (password.length >= 8) {
      score++;
    }
    if (password.contains(new RegExp(r'[a-z]'))) {
      score++;
    }
    if (password.contains(new RegExp(r'[A-Z]'))) {
      score++;
    }
    if (password.contains(new RegExp(r'[0-9]'))) {
      score++;
    }
    if (password
        .contains(new RegExp(r'[!@#\$%\^&\*()\-_=+{}\[\]|\\:;\"\<>,/?]'))) {
      score++;
    }

    if (score < 3) {
      return 1; //faible
    } else if (score < 5) {
      return 2; //moyenne
    } else {
      return 3; //fort
    }
  }

  Widget getIndicator(String password) {
    if (password == "") {
      return Container();
    }
    if (getLevel(password) == 1) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: Container(
              height: 3,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xffff3233),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      );
    } else if (getLevel(password) == 2) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: Container(
              height: 3,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xffff3233),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: Container(
              height: 3,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xffff8002),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: Container(
              height: 3,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xffff3233),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: Container(
              height: 3,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xffff8002),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: Container(
              height: 3,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xff00b26c),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
