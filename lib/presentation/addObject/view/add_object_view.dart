import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../ressources/color_manager.dart';
import '../../ressources/fonts_manager.dart';
import '../../ressources/styles_manager.dart';
import '../../ressources/values_manager.dart';
import '../viewModel/add_object_viewmodel.dart';

class AddObjectView extends StatefulWidget {
  const AddObjectView({super.key});

  @override
  State<AddObjectView> createState() => _AddObjectViewState();
}

class _AddObjectViewState extends State<AddObjectView> {  

  final AddObjectViewModel _viewModel = instance<AddObjectViewModel>(); 
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController(); 

  final _formKey = GlobalKey<FormState>();

  String _selectedType = "car";
  List<String> _typeOptions = ['car', 'kid', 'pet'];

  _bind() {
    _viewModel.start(); // tell view model start your job
    _nameController.addListener(() => _viewModel.setName(_nameController.text));
    _typeController.addListener(() => _viewModel.setType(/*_typeController.text*/_selectedType));
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
                _viewModel.start();
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      Text(
                        "Add new object",
                        style: getBoldStyle(
                          fontSize: 18,
                          color: Color(0xff1b2028),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),






                
                SizedBox(
                  height: 16.0,
                ),
                _buildNameTextField(),
                SizedBox(
                  height: 16.0,
                ),
                _buildTypeTextField(),
                SizedBox(
                  height: 24.0,
                ),
                _buildButton(),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




Widget _buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p24,
        right: AppPadding.p24,
      ),
      child: StreamBuilder<bool>(
        stream: _viewModel.outIsNameValid,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 2.0,
                ),
                child: Text(
                  "Name :",
                  style: getRegularStyle(
                      color: Colors.black, fontSize: FontSize.s16),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.only(left: 8.0),
                  hintText: "Name",
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.red),
                  ),
                  hintStyle: getMediumStyle(
                      color: ColorManager.splashGrey, fontSize: FontSize.s16),
                  //labelText: AppStrings.password.tr(),
                  errorStyle: TextStyle(
                    color: ColorManager.red,
                  ),
                  errorText: (snapshot.data ?? true) ? null : "invalid name",
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /*Widget _buildTypeTextField() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p24,
        right: AppPadding.p24,
      ),
      child: StreamBuilder<bool>(
        stream: _viewModel.outIsTypeValid,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 2.0,
                ),
                child: Text(
                  "Type :",
                  style: getRegularStyle(
                      color: Colors.black, fontSize: FontSize.s16),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _typeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.only(left: 8.0),
                  hintText: "Type",
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.red),
                  ),
                  hintStyle: getMediumStyle(
                      color: ColorManager.splashGrey, fontSize: FontSize.s16),
                  //labelText: AppStrings.password.tr(),
                  errorStyle: TextStyle(
                    color: ColorManager.red,
                  ),
                  errorText: (snapshot.data ?? true) ? null : "invalid type",
                ),
              ),
            ],
          );
        },
      ),
    );
  }*/





  Widget _buildTypeTextField() {
  return Padding(
    padding: const EdgeInsets.only(
      left: AppPadding.p24,
      right: AppPadding.p24,
    ),
    child: StreamBuilder<bool>(
      stream: _viewModel.outIsTypeValid,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 2.0,
              ),
              child: Text(
                "Type :",
                style: getRegularStyle(
                    color: Colors.black, fontSize: FontSize.s16),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            DropdownButtonFormField<String>(
              value: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                  _viewModel.setType(value); // notify view model of the change
                });
              },
              items: _typeOptions
                  .map((type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.only(left: 8.0),
                hintText: "Type",
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.red),
                ),
                hintStyle: getMediumStyle(
                    color: ColorManager.splashGrey, fontSize: FontSize.s16),
                errorStyle: TextStyle(
                  color: ColorManager.red,
                ),
                errorText:
                    (snapshot.data ?? true) ? null : "invalid type",
              ),
            ),
          ],
        );
      },
    ),
  );
}

  Widget _buildButton() {
    return Padding(
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
                      _viewModel.addNewObject();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,color: Colors.white,),
                  Text(
                    "add",
                    style:
                        getBoldStyle(color: Colors.white, fontSize: FontSize.s16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  
  






  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}