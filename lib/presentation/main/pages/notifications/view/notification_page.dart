import 'dart:ffi';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:http_course/presentation/ressources/styles_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../../app/app_prefs.dart';
import '../../../../../app/di.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../ressources/color_manager.dart';
import '../../../../ressources/routes_manager.dart';
import '../../../../ressources/strings_manager.dart';
import '../viewModel/notfication_viewMode.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  // page view controller
  final PageController _pageController = PageController();

  final NotificationViewModel _viewModel = instance<NotificationViewModel>();

  late double percentageCar = 0;
  late double percentagePet = 0;
  late double percentageKid = 0;

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
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
        stream: _viewModel.outputDash,
        builder: (context, snapshot) {
          //print(snapshot.data?[1].name ?? "null");
          int countCar =
              snapshot.data?.where((e) => e.type == "car").length ?? 0;
          int countPet =
              snapshot.data?.where((e) => e.type == "pet").length ?? 0;
          int countKid =
              snapshot.data?.where((e) => e.type == "kid").length ?? 0;
          List<OneObject>? objectsWithLowBattery =
              snapshot.data?.where((obj) => obj.batteryLevel < 10).toList();
          print(objectsWithLowBattery?.isEmpty);

          List<BarChartModel> data = [
            BarChartModel(
                type: AppStrings.carType.tr(),
                nember: countCar,
                color: charts.ColorUtil.fromDartColor(Color(0xfffec606))),
            BarChartModel(
                type: "Kid",
                nember: countKid,
                color: charts.ColorUtil.fromDartColor(Color(0xff082bcb))),
            BarChartModel(
                type: "Pet",
                nember: countPet,
                color: charts.ColorUtil.fromDartColor(Color(0xfffa5608))),
          ];

          List<charts.Series<BarChartModel, String>> series = [
            charts.Series(
              id: "type",
              data: data,
              domainFn: (BarChartModel series, _) => series.type,
              measureFn: (BarChartModel series, _) => series.nember,
              colorFn: (BarChartModel series, _) => series.color,
            ),
          ];

          /* Map<String, double> data = {
            "car": countCar.toDouble(),
            "pet": countPet.toDouble(),
            "kid": countKid.toDouble(),
          };*/

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: Text(
                    "Dashboard",
                    style: getBoldStyle(
                      fontSize: 18,
                      color: Color(0xff1b2028),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 24.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xffededed),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 10),
                          child: Text(
                            "Object percentage : ",
                            style: getRegularStyle(
                              fontSize: 14,
                              color: Color(0xff1b2028),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          //width: 200,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, top: 15, bottom: 10),
                            child: charts.BarChart(
                              series,
                              animate: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 24.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xffededed),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 10),
                          child: Text(
                            "Object Total: ${snapshot.data?.length}",
                            style: getRegularStyle(
                              fontSize: 14,
                              color: Color(0xff1b2028),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 15, bottom: 10, right: 20),
                            child: GestureDetector(
                              onTap: () {
                      Navigator.of(context) 
                          .pushNamed(RoutesManager.editRoute);
                    },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                                //width: 30,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Edit",
                                        style: getRegularStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xffededed),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 15,
                            right: 20,
                          ),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.electric_bolt_outlined,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Battery Alert :",
                                style: getRegularStyle(
                                  fontSize: 14,
                                  color: Color(0xff1b2028),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 65,
                          width: double.infinity,
                          child: objectsWithLowBattery != null &&
                                  objectsWithLowBattery.isNotEmpty
                              ? PageView.builder(
                                  controller: _pageController,
                                  itemCount: objectsWithLowBattery.length,
                                  itemBuilder: (context, index) {
                                    OneObject object =
                                        objectsWithLowBattery[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        //top: 15,
                                        right: 20,
                                      ),
                                      child: Container(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Battery",
                                                  style: getSemiBoldStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  "${object.batteryLevel.toString()}%",
                                                  style: getRegularStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            width: 1.5,
                                            decoration: BoxDecoration(
                                              color: ColorManager.splashGrey
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Type",
                                                  style: getSemiBoldStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  /*object.type*/ object.type == "car" ? "Vehicle" : object.type,
                                                  style: getRegularStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            width: 1.5,
                                            decoration: BoxDecoration(
                                              color: ColorManager.splashGrey
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "ID",
                                                  style: getSemiBoldStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  object.id.substring((object.id.length)-5,object.id.length),
                                                  style: getRegularStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            width: 1.5,
                                            decoration: BoxDecoration(
                                              color: ColorManager.splashGrey
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Name",
                                                  style: getSemiBoldStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  object.name,
                                                  style: getRegularStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                    );
                                  },
                                )
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[ Text('No objects'),Text("with low battery"),SizedBox(height: 20,)]),
                        ),
                        // TODO add swipe guide
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  double getPercentageCar(snap) {
    return 0.3;
  }

  double getPercentagePet(data) {
    return 0.6;
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

  double getPercentageKid(data) {
    return 0.9;
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

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
