import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../ressources/assets_manager.dart';
import '../../ressources/color_manager.dart';
import '../../ressources/fonts_manager.dart';
import '../../ressources/strings_manager.dart';
import '../../ressources/styles_manager.dart';
import '../../ressources/values_manager.dart';
import '../viewModel/forgot_password_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  bind() {
    _viewModel.start();
    _emailTextEditingController.addListener(
        () => _viewModel.setEmail(_emailTextEditingController.text));
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.forgotPassword();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SafeArea(
      child: Container(
        //constraints: const BoxConstraints.expand(),
        padding: EdgeInsets.only(top: AppPadding.p16),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          Text(
                            AppStrings.back.tr(),
                            style: getSemiBoldStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    AppStrings.resetPassword.tr(),
                    style: getSemiBoldStyle(
                      color: Colors.black,
                      fontSize: 32,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Wrap(
                    children: [
                      Text(
                        AppStrings.resetPasswordMsg.tr(),
                        style: getRegularStyle(
                            color: ColorManager.splashGrey,
                            fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p24, right: AppPadding.p24),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsEmailValid,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                            ),
                            child: Text(
                              AppStrings.emailAdress.tr(),
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: FontSize.s16),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextEditingController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                hintStyle: getMediumStyle(
                                    color: ColorManager.splashGrey,
                                    fontSize: FontSize.s16),
                                hintText: AppStrings.exempleMail.tr(),
                                //labelText: AppStrings.emailHint,
                                errorStyle: TextStyle(
                                  color: ColorManager.red,
                                ),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : AppStrings.invalidEmail.tr()),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p24, right: AppPadding.p24),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s48,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: (snapshot.data ?? false)
                                ? () => _viewModel.forgotPassword()
                                : null,
                            child:  Text(AppStrings.resetPassword.tr(),
                            style: getBoldStyle(
                                color: Colors.white, fontSize: FontSize.s16),)),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
