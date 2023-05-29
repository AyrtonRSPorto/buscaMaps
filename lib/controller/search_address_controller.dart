import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../components/constants.dart';

class SearchAddressController extends TextEditingController {
  final TextEditingController controllerSearchGoing = TextEditingController();
  final TextEditingController controllerSearchDestination =
      TextEditingController();
  final Completer<GoogleMapController> controllerGoogleMaps = Completer();
  ValueNotifier<bool> reload = ValueNotifier(false);
  double? latGoing;
  double? logGoing;
  double? latDestination;
  double? logDestination;
  late LatLng sourceLocation;
  late LatLng destination;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  Set<Marker> markers = <Marker>{};
  late GoogleMapController googleMapController;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }

  void getPolyPoitns() async {
    reload.value = false;
    PolylinePoints polylinePoints = PolylinePoints();
    markers.clear();
    polylineCoordinates.clear();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(latGoing!, logGoing!),
      PointLatLng(latDestination!, logDestination!),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      markers.addAll({
        Marker(
            markerId: const MarkerId('source'),
            position: LatLng(latGoing!, logGoing!)),
        Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(latDestination!, logDestination!))
      });
      reload.value = true;
      googleMapController = await controllerGoogleMaps.future;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 12.0,
            target: LatLng(((latDestination! + latGoing!) / 2),
                ((logDestination! + logDestination!) / 2)),
          ),
        ),
      );
    }
  }
}
