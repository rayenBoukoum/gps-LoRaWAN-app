import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_course/presentation/objectDetail/viewModel/object_detail_viewmodel.dart';

import '../../../app/di.dart';
import '../../../domain/model/models.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../ressources/color_manager.dart';
import '../../ressources/routes_manager.dart';
import '../../ressources/strings_manager.dart';
import '../../ressources/styles_manager.dart';

class ObjectDetailsView extends StatefulWidget {
  final String id;
  const ObjectDetailsView({required this.id});

  @override
  State<ObjectDetailsView> createState() => _ObjectDetailsViewState();
}

class _ObjectDetailsViewState extends State<ObjectDetailsView> {
  final ObjectDetailsViewModel _viewModel = instance<ObjectDetailsViewModel>();

  bool _mapFullSreen = false;

  @override
  void initState() { 
    bind();
    super.initState();
  }

  bind() {
    _viewModel.setId(widget.id);
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("h:mm a").format(DateTime.now()),
                style: getSemiBoldStyle(color: ColorManager.black, fontSize: 14),
              ),
              Text(
                DateFormat("EEEE, d MMMM y", "fr_FR").format(DateTime.now()),
                style: getRegularStyle(color: ColorManager.black, fontSize: 14),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        //elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          
        ),
        
      ),
      body: StreamBuilder<ObjectDetails>(
        stream: _viewModel.outputObjectDetails,
        builder: (context, snapshot) {
          return _getItems(snapshot.data);
        },
      ),
    );
  }

  Widget _getItems(ObjectDetails? objectDetails) {
    if (objectDetails != null) { 
      return Stack(
        children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints contraints) {
            return Stack(
              children: [
                
                SizedBox(
                  height: contraints.maxHeight / 2,
                  child: GoogleMap(
                    
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                        bearing: 192.8334901395799,
                        target: LatLng(objectDetails.position?.lat as double,
                            objectDetails.position?.long as double),
                        //tilt: 59.440717697143555,
                        zoom: 15),
                    markers: Set<Marker>.from(
                      [
                        Marker(
                          markerId: MarkerId(objectDetails.id),
                          position: LatLng(objectDetails.position?.lat as double,
                              objectDetails.position?.long as double),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 13,
                  child: GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(context, RoutesManager.oneObjectMapRoute,
                            arguments: {
                              'latitude': objectDetails.position?.lat ?? 0.0,
                              'longitude': objectDetails.position?.long ?? 0.0 
                            });
                      },
                    child: Container(
                width: 38,
                height: 38,
                //margin: EdgeInsets.only(right: 10.0, top: 10.0,),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  
                    child: Icon(Icons.fullscreen, color: ColorManager.splashGrey, size: 30,)
                  
                ),
              ),
                    ),
                ),
              ],
            );
          }),
          DraggableScrollableSheet(
              
              initialChildSize: 0.5,
              minChildSize: 0.5,
              //maxChildSize: 0.9,
              builder:(BuildContext context, ScrollController scrollController) {
                return Container(
                    color: Colors.white,
                    
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    controller: scrollController,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 70,
                                  height: 5,
                                 
                                  decoration: BoxDecoration(
                                    color: ColorManager.splashGrey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              Text(
                                "${objectDetails.name} details :",
                                style: getSemiBoldStyle(color: ColorManager.black, fontSize: 16),
                              ),

                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      height: 110,
                                      width: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: AutoSizeText(AppStrings.batteryLevel.tr(),
                                                  style: getRegularStyle(color: ColorManager.white, fontSize: 14),    
                                                  maxLines: 1,                              
                                                  ),
                                                ),
                                                Icon(Icons.electric_bolt_outlined,color: Colors.white,),
                                              ],
                                            ),
                                            Expanded(
                                                  child: AutoSizeText("${objectDetails.batteryLevel.toString()}%",
                                                  style: getBoldStyle(color: ColorManager.white, fontSize: 55),    
                                                  maxLines: 1,                              
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: (MediaQuery.of(context).size.width)-348,),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorManager.primary,
                                          width: 1.2,
                                        ),
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      height: 110,
                                      width: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: AutoSizeText(AppStrings.farFromYou.tr(),
                                                  style: getRegularStyle(color: ColorManager.primary, fontSize: 14),    
                                                  maxLines: 1,                              
                                                  ),
                                                ),
                                                Icon(Icons.gps_fixed,color: ColorManager.primary,),
                                              ],
                                            ),
                                            Expanded(
                                                  child: AutoSizeText("${objectDetails.farFromYou.toString()}KM",
                                                  style: getBoldStyle(color: ColorManager.primary, fontSize: 55),    
                                                  maxLines: 1,                              
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                "${objectDetails.name} position :",
                                style: getSemiBoldStyle(color: ColorManager.black, fontSize: 16),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.gps_fixed,size: 18,),
                                  SizedBox(width: 5,),
                                  Text(
                                AppStrings.latitude.tr(),
                                style: getBoldStyle(color: ColorManager.black, fontSize: 14),
                              ),
                              SizedBox(width: 15,),
                              Text(
                                "${objectDetails.position?.lat}°",
                                style: getRegularStyle(color: ColorManager.black, fontSize: 14),
                              ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.gps_fixed,size: 18,),
                                  SizedBox(width: 5,),
                                  Text(
                                AppStrings.longitude.tr(),
                                style: getBoldStyle(color: ColorManager.black, fontSize: 14),
                              ),
                              SizedBox(width: 15,),
                              Text(
                                "${objectDetails.position?.long}°",
                                style: getRegularStyle(color: ColorManager.black, fontSize: 14),
                              ),
                                ],
                              ),

                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                AppStrings.moreDetails.tr(),
                                style: getSemiBoldStyle(color: ColorManager.black, fontSize: 16),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      AutoSizeText(
                                          AppStrings.id.tr(),
                                          style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                                          maxLines: 1,
                                        ),
                                      
                                      AutoSizeText(
                                          objectDetails.id.substring((objectDetails.id.length)-5,objectDetails.id.length),
                                          style: getRegularStyle(color: ColorManager.black, fontSize: 14),
                                          maxLines: 1,

                                        ),
                                      
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                    width: 1.5,
                                    decoration: BoxDecoration(
                                    color: ColorManager.splashGrey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  ),
                                  Column(
                                    children: [
                                      AutoSizeText(
                                          AppStrings.createdAt.tr(),
                                          style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                                          maxLines: 1,

                                        ),
                                      
                                      AutoSizeText(
                                          objectDetails.createdAt,
                                          style: getRegularStyle(color: ColorManager.black, fontSize: 14),
                                          maxLines: 1,

                                        ),
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                    width: 1.5,
                                    decoration: BoxDecoration(
                                    color: ColorManager.splashGrey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  ),
                                  Column(
                                    children: [
                                      AutoSizeText(
                                          AppStrings.type.tr(),
                                          style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                                          maxLines: 1,

                                        ),
                                      
                                      AutoSizeText(
                                          /*objectDetails.type*/ objectDetails.type == "car" ? "Vehicle" : objectDetails.type,//TODO change correctly
                                          style: getRegularStyle(color: ColorManager.black, fontSize: 14),
                                          maxLines: 1,

                                        ),
                                    ],
                                  ),
                                ],
                              ),


                              SizedBox(
                                height: 16.0,
                              ),
                              
                              


                            ],
                          ),
                        )
                    ],
                  ),
                  
                  /*ListView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: scrollController,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 70,
                                  height: 5,
                                 
                                  decoration: BoxDecoration(
                                    color: ColorManager.splashGrey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              Text('Object details'),
                            ],
                          ),
                        );
                      }
                      return Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          onTap: () {},
                          leading: Icon(Icons.car_crash),
                          title: Text("data"),
                          trailing: Text("15.25"),
                        ),
                      );
                    },
                  ),*/
                );
              })
        ],
      );
    } else {
      return Container();
    }
  }
}




/*



 */






