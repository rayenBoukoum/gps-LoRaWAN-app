import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../ressources/color_manager.dart';

class OneObjectMapView extends StatefulWidget {  
  final double latitude;
  final double longitude;
  const OneObjectMapView({required this.latitude, required this.longitude});  

  @override
  State<OneObjectMapView> createState() => _OneObjectMapViewState();
}

class _OneObjectMapViewState extends State<OneObjectMapView> {

  MapType mapType = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            //mapToolbarEnabled: true,
            //compassEnabled: false,
            zoomControlsEnabled: true,
            mapType: mapType,
            initialCameraPosition: CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(
                    widget.latitude as double, widget.longitude as double),
                //tilt: 59.440717697143555,
                zoom: 10),
            markers: Set<Marker>.from(
              [
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(
                      widget.latitude as double, widget.longitude as double),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 38,
                height: 38,
                margin: EdgeInsets.only(right: 10.0, top: 10.0,),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  
                    child: Icon(Icons.fullscreen_exit, color: ColorManager.splashGrey, size: 30,)
                  
                ),
              ),
            ),
          ),
          GestureDetector(
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
                margin: EdgeInsets.only(right: 10.0, top: 58.0,),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Icon(Icons.map_outlined, color: ColorManager.splashGrey, size: 30,)
                ),
              ),
            ),
          ),
          GestureDetector(
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
                margin: EdgeInsets.only(right: 10.0, top: 106.0,),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Icon(Icons.map_rounded, color: ColorManager.splashGrey, size: 30,)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
