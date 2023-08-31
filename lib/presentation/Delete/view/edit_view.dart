import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../app/di.dart';
import '../../../domain/model/models.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../ressources/assets_manager.dart';
import '../../ressources/color_manager.dart';
import '../../ressources/routes_manager.dart';
import '../../ressources/strings_manager.dart';
import '../../ressources/styles_manager.dart';
import '../viewModel/edit_viewModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final EditViewModel _viewModel = instance<EditViewModel>();

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    _viewModel.start();
    print("actualisser");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        leading: Ico,
        title: Text("Edit Page",style: getRegularStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),*/
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Container(
            child: snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                Container(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<List<OneObject>>(
      stream: _viewModel.outputMap,
      builder: (context, snapshot) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              getListItems(snapshot.data ?? []),
            ],
          ),
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
      return SafeArea(
        child: Column(
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
                        AppStrings.editObject.tr(),
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
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xffededed),
                  ),
                ),
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.edit.tr(),
                              style: getBoldStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.swipe_right,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      AppStrings.swipe.tr(),
                      style: getBoldStyle(color: Colors.black, fontSize: 16),
                    ),
                    Container(
                      height: 60,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.swipe_left,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              AppStrings.delete.tr(),
                              style: getBoldStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  60 -
                  10 -
                  8 -
                  8 -
                  30 -
                  10 /*- kToolbarHeight*/,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8),
                      child: Material(
                        child: Slidable(
                          startActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              backgroundColor: Colors.green,
                              icon: Icons.edit,
                              label: AppStrings.edit.tr(),
                              onPressed: (BuildContext context) {
                                

                                    Navigator.pushNamed(context, RoutesManager.editObjectRoute,
                            arguments: {
                              'id': items[index].id,
                              'name': items[index].name ,
                              'type': items[index].type 
                            }); 
                              },
                            ),
                          ]),
                          endActionPane:
                              ActionPane(motion: BehindMotion(), children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: AppStrings.delete.tr(),
                              /*onPressed: (BuildContext context) { 
                                        _viewModel.deleteObject(items[index].id);
                                       },*/
                              onPressed: (BuildContext context) {
                               showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        AppStrings.areYouSureToDelete.tr(),
                                        style: getSemiBoldStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text(
                                            AppStrings.no.tr(),
                                            style: getSemiBoldStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _viewModel
                                                .deleteObject(items[index].id);  

                                            Navigator.of(context).pop(true);
                                            // TODO Actualiser la page ici
                                          },
                                          child: Text(
                                            AppStrings.yes.tr(),
                                            style: getSemiBoldStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((confirmed) {
                                  if (confirmed) {
                                    //TODO Do something after delete
                                    print("supprimer avec success");
                                  }
                                });
                              },
                            ),
                          ]),
                          child: ListTile(
                            onTap: () {
                              print(items[index].id);
                            },
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: getBorderColorByBatteryLife(
                                    items[index].batteryLevel),
                                width: 1,
                              ),
                              //borderRadius: BorderRadius.circular(12.0),
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
                              /*items[index].type*/ items[index].type == "car" ? "Vehicle" : items[index].type,
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
                                progressColor:
                                    getColor(items[index].batteryLevel),
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
                      ),
                    );
                  }),
            ),
          ],
        ),
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

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
