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
import '../../../../ressources/fonts_manager.dart';
import '../../../../ressources/routes_manager.dart';
import '../../../../ressources/strings_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_course/presentation/ressources/assets_manager.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart'
    as maps;

import '../../../../ressources/styles_manager.dart';
import '../../../../ressources/values_manager.dart';
import '../viewmodel/map_viewmodel.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final MapViewModel _viewModel = instance<MapViewModel>();

  bool carFilterIsSelected = false;
  bool petFilterIsSelected = false;
  bool kidFilterIsSelected = false;
  bool allTypesIsSelected = true;

  String searchWord = "";

  late Set<maps.Marker> data;
  final TextEditingController searchController = TextEditingController();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  MapType mapType = MapType.hybrid;

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
        if (!snapshot.hasData) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset(JsonAssets.loading),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Text(
                    "loading",
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: FontSize.s18),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ));
        }

        data = snapshot.data!
            .map((object) => maps.Marker(
                  markerId: MarkerId(object.id),
                  position: LatLng(object.position!.lat, object.position!.long),
                  icon: _getMarkerIcon(
                      object.type), // définir l'icône en fonction du type
                  infoWindow: InfoWindow(
                    title: object.name,
                    snippet: /*object.type */ object.type == "car" ? "Vehicle" : object.type,
                  ),
                ))
            .toSet();

        return Stack(
          children: [
            GoogleMap(
              mapType: mapType,
              markers: data,
              initialCameraPosition: CameraPosition(
                target: LatLng(snapshot.data?[0].position?.lat ?? 0,
                    snapshot.data?[0].position?.long ?? 0),
                zoom: 14.4746,
              ),
            ),
            Positioned(
              top: 18,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        carFilterIsSelected = !carFilterIsSelected;
                        petFilterIsSelected = false;
                        kidFilterIsSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: carFilterIsSelected
                            ? Border.all(width: 2, color: Colors.red)
                            : null,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Pets",
                                style: getMediumStyle(
                                    color: Colors.red, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        petFilterIsSelected = !petFilterIsSelected;
                        carFilterIsSelected = false;
                        kidFilterIsSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: petFilterIsSelected
                            ? Border.all(width: 2, color: Colors.blue)
                            : null,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(AppStrings.carType.tr(),
                                style: getMediumStyle(
                                    color: Colors.blue, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        kidFilterIsSelected = !kidFilterIsSelected;
                        petFilterIsSelected = false;
                        carFilterIsSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: kidFilterIsSelected
                            ? Border.all(width: 2, color: Colors.green)
                            : null,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Kids',
                                style: getMediumStyle(
                                    color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // add more types and colors here
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mapType = MapType.hybrid;
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 38,
                    height: 38,
                    margin: EdgeInsets.only(
                      right: 10.0,
                      top: 58.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white, //.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.map_outlined,
                      color: ColorManager.splashGrey,
                      size: 30,
                    )),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mapType = MapType.terrain;
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 38,
                    height: 38,
                    margin: EdgeInsets.only(
                      right: 10.0,
                      top: 106.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white, //.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.map_rounded,
                      color: ColorManager.splashGrey,
                      size: 30,
                    )),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showObjectDetails(BuildContext context, OneObject object) {
    // show details about the object
  }

  Widget _buildMarkerDetails(OneObject object) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            object.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Latitude: ${object.position?.lat ?? 0}, Longitude: ${object.position?.long ?? 0}",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  BitmapDescriptor _getMarkerIcon(String type) {
    switch (type) {
      case 'pet':
        return BitmapDescriptor.defaultMarker;
      case 'kid':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'car':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
