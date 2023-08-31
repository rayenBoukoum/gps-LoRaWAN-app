import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_course/app/di.dart';
import 'package:http_course/presentation/Login/viewModel/login_viewmodel.dart';
import 'package:http_course/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:http_course/presentation/ressources/color_manager.dart';
import 'package:http_course/presentation/ressources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../ressources/assets_manager.dart';
import '../../ressources/fonts_manager.dart';
import '../../ressources/routes_manager.dart';
import '../../ressources/strings_manager.dart';
import '../../ressources/styles_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  final LoginViewModel _viewModel = instance<LoginViewModel>();   
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController(); 

  final _formKey = GlobalKey<FormState>();

  bool isClear = true;

  _bind() {
    _viewModel.start(); // tell view model start your job
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _userPasswordController.addListener(
        () => _viewModel.setPassword(_userPasswordController.text));
    _viewModel.isUserLoggedInSUccessfulyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(RoutesManager.mainRoute);
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
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SafeArea(
      child: Container(
        //height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: AppPadding.p16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.login.tr(),
                        style: getSemiBoldStyle(
                          color: Colors.black,
                          fontSize: 32,
                        ),
                      ),
                      AutoSizeText(
                        AppStrings.toStartTracking.tr(),
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
                  child: Row(
                    children: [
                      Expanded(child: AutoSizeText(AppStrings.dontHaveAccount.tr(),style: getRegularStyle(
                                  color: Colors.black,
                                  fontSize: FontSize.s16),
                                  maxLines: 1,)),
                      TextButton(
                        onPressed: (){
                            Navigator.pushNamed(
                              context, RoutesManager.registerRoute);
                        }, 
                        child: Expanded(child: AutoSizeText(AppStrings.register.tr(),style: getMediumStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16), maxLines: 1,),)
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p24,
                    right: AppPadding.p24,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outIsUserNameValid,
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
                                  color: Colors.black,
                                  fontSize: FontSize.s16),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
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
                                  errorStyle: TextStyle(color: ColorManager.red,),
                              //labelText: AppStrings.username.tr(),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.userNameError.tr(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p24,
                    right: AppPadding.p24,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            obscureText: isClear,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _userPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                onPressed: (){
                                  setState(() {
                                    isClear = !isClear;
                                  });
                                }, 
                                icon: isClear ? Icon(Icons.visibility_off)  : Icon(Icons.visibility),
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
                              //labelText: AppStrings.password.tr(),
                              errorStyle: TextStyle(color: ColorManager.red,),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.passwordError.tr(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                              context, RoutesManager.forgetPasswordRoute);
                      },
                      child: Text(
                        AppStrings.forgetPassword.tr(),
                        style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p24,
                    right: AppPadding.p24,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.areAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s48,
                        child: ElevatedButton(
                          
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          child: Text(
                            AppStrings.login.tr(),
                            style: getBoldStyle(
                                color: Colors.white, fontSize: FontSize.s16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children:[
                      Expanded(child: Divider(thickness: 1,)),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(AppStrings.orLoginWith.tr(),
                        style: getLightStyle(color: ColorManager.splashGrey,fontSize: 14,),),
                      ),
                      Expanded(child: Divider(thickness: 1,)),


                    ],
                    
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0,),
                  child: SizedBox(
                          width: double.infinity,
                          height: AppSize.s48,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                Icon(Icons.mail),
                                SizedBox(width: 8.0,),
                                Text(
                                  AppStrings.continueWith.tr(),
                                  style: getBoldStyle(
                                      color: Colors.white, fontSize: FontSize.s16),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 24,
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
