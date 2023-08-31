import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:http_course/presentation/main/pages/search/viewmodel/search_viewmodel.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/app_prefs.dart';
import '../../../../../app/di.dart';
import '../../../../../domain/model/models.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../ressources/color_manager.dart';
import '../../../../ressources/routes_manager.dart';
import '../../../../ressources/strings_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_course/presentation/ressources/assets_manager.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../ressources/styles_manager.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final SearchViewModel _viewModel = instance<SearchViewModel>(); 

  final TextEditingController searchController = TextEditingController();

  int current = 0;

  List<String> categories = [
    AppStrings.allObject.tr(),
    AppStrings.carType.tr(),
    AppStrings.animalType.tr(),
    AppStrings.kidType.tr(),
  ];

  String userName = "";

  List<IconData> iconOfCategories = [
    Icons.all_inbox,
    Icons.directions_car_filled,
    Icons.pets,
    Icons.person,
  ];

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
    _getUserName();
  }


  Future<void> _getUserName() async {
    _appPreferences.getUserName().then((value) => {
          if (value != null)
            {
                userName = value, 
            }
        });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<FlowState>(
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
    return StreamBuilder<List<OneObject>>( 
      stream: _viewModel.outputMap,
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only( 
                right: 24.0,
                left: 24.0,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.helloMessage.tr(),
                        style: getRegularStyle(
                          fontSize: 14,
                          color: Color(0xff1b2028),
                        ),
                      ),
                      Text(
                        userName,
                        style: getBoldStyle(
                          fontSize: 16,
                          color: Color(0xff1b2028),
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xffa4aaad),
                    backgroundImage: NetworkImage("https://png.pngtree.com/png-vector/20220817/ourmid/pngtree-cartoon-man-avatar-vector-ilustration-png-image_6111064.png"
                        /*"https://i.pinimg.com/originals/ae/ec/c2/aeecc22a67dac7987a80ac0724658493.jpg"*/),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        if (!mounted) return;
                       setState(() {
                          _viewModel.setSearchWord(value);
                        });
                      },
                      controller: searchController,
                      style: getRegularStyle(
                        color: Color(0xff878787),
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 13),
                        prefixIcon: const IconTheme(
                            data: IconThemeData(
                              color: Color(0xff878787),
                            ),
                            child: Icon(Icons.search)),
                        hintText: AppStrings.searchBarHint.tr(),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffededed),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffededed),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffededed),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffededed),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffededed),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffededed),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintStyle: getRegularStyle(
                          color: Color(0xff878787),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    height: 49,
                    width: 49,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorManager.primary,
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!mounted) return;
                      setState(() {
                        current = index;
                        print(index);
                        switch (index) {
                          case 0:
                            _viewModel.unsetAll();

                            break;
                          case 1:
                            _viewModel.unsetAll();
                            _viewModel.setCarTypeFilterOn();

                            break;
                          case 2:
                            _viewModel.unsetAll();
                            _viewModel.setPetTypeFilterOn();

                            break;
                          case 3:
                            _viewModel.unsetAll();
                            _viewModel.setKidTypeFilterOn();
                            break;
                          default:
                            _viewModel.unsetAll();
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 24 : 15,
                        right: index == categories.length - 1 ? 24 : 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      height: 36,
                      decoration: BoxDecoration(
                        color: current == index
                            ? ColorManager.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: current == index
                            ? null
                            : Border.all(
                                color: Color(0xffededed),
                                width: 1,
                              ),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            iconOfCategories[index],
                            color: (current == index)
                                ? Colors.white
                                : ColorManager.primary,
                                size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            categories[index],
                            style: getMediumStyle(
                              color: (current == index)
                                  ? Colors.white
                                  : ColorManager.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            getListItems(snapshot.data ?? []),
          ],
        );
      },
    );
  }

  Widget getListItems(List<OneObject> items) {
    if (items.isEmpty) {
      return Expanded(
          child: Center(
        child: SizedBox(
      height: 100,
      width: 100,
      child: Lottie.asset(JsonAssets.noData), 
    ),
      ));
    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: Material(
                  child: ListTile(
                    onTap: () {
                      /*Navigator.of(context) 
                          .pushNamed(RoutesManager.objectDetailsRoute);*/

                          Navigator.pushNamed(context, RoutesManager.objectDetailsRoute,
                            arguments: {
                              'id': items[index].id
                            });
                            
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: getBorderColorByBatteryLife(
                            items[index].batteryLevel),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    tileColor: getBackgroundColorByBatteryLife(
                        items[index].batteryLevel),
                    title: Text(
                      items[index].name,
                      style: getBoldStyle(
                        fontSize: 16,
                        color: getTextColorByBatteryLife(
                            items[index].batteryLevel),
                      ),
                    ),
                    subtitle: Text(
                      /*items[index].type*/ items[index].type == "car" ? "Vehicle" : items[index].type,//TODO to change correctly
                      style: getRegularStyle(
                        fontSize: 16,
                        color: getTextColorByBatteryLife(
                            items[index].batteryLevel),
                      ),
                    ),
                    leading: Container(
                      child: CircularPercentIndicator(
                        rotateLinearGradient: true,
                        radius: 25.0,
                        lineWidth: 4.0,
                        animation: true,
                        percent: (items[index].batteryLevel) / 100,
                        center: new Icon(
                          getIconByType(items[index].type),
                          color: Color(0xff878787),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Color(0xffededed),
                        progressColor: getColor(items[index].batteryLevel),
                      ),
                    ),
                    trailing: Container(
                      width: 50,
                      height: 50,
                      child: SvgPicture.asset(
                        SvgAssets.details,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }

  Color getColor(double levelBattery) {
    if (levelBattery > 0 && levelBattery <= 10) {
      return Color(0xffff3233);
    } else if (levelBattery > 10 && levelBattery <= 30) {
      return Color(0xffff8002);
    } else if (levelBattery > 30 && levelBattery <= 40) {
      return Color(0xfffed502);
    } else {
      return Color(0xff00b26c);
    }
  }

  Color getBackgroundColorByBatteryLife(double levelBattery) {
    if (levelBattery > 0 && levelBattery < 20) {
      return ColorManager.redAlert;
    } else if (levelBattery > 20 && levelBattery < 40) {
      return ColorManager.yellowAlert;
    } else {
      return ColorManager.bleuAlert;
    }
  }

  Color getBorderColorByBatteryLife(double levelBattery) {
    if (levelBattery > 0 && levelBattery < 20) {
      return ColorManager.redAlertBorder;
    } else if (levelBattery > 20 && levelBattery < 40) {
      return ColorManager.yellowAlertBorder;
    } else {
      return ColorManager.bleuAlertBorder;
    }
  }

  Color getTextColorByBatteryLife(double levelBattery) {
    if (levelBattery > 0 && levelBattery < 20) {
      return ColorManager.redText;
    } else if (levelBattery > 20 && levelBattery < 40) {
      return ColorManager.yellowText;
    } else {
      return ColorManager.bleuText;
    }
  }

  IconData getIconByType(String type) {
    if (type == 'car') {
      return Icons.directions_car_filled;
    } else if (type == "pet") {
      return Icons.pets;
    } else if (type == "kid") {
      return Icons.person;
    } else {
      return Icons.clear_all;
    }
  }

  Widget batteryLevelIndicator(double batteryLevel, IconData icon) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: batteryLevel / 100,
            strokeWidth: 5,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Icon(
              icon,
              color: Colors.green,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  String getIcon(String type) {
    switch (type) {
      case "car":
        return SvgAssets.carLogo;
      case "pet":
        return SvgAssets.pet;
      case "kid":
        return SvgAssets.kid;
      default:
        return SvgAssets.carLogo;
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
