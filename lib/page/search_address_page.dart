import 'package:buscamaps/components/constants.dart';
import 'package:buscamaps/controller/search_address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:location/location.dart';
import '../widget/button_widget.dart';
import '../widget/icon_text_field_widget.dart';
import '../widget/text_field_icon_widget.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({super.key});

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  final SearchAddressController _controller = SearchAddressController();

  @override
  void initState() {
    _controller.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h, left: 8.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconTextFieldCustomWidget(
                        controllerSearchGoing:
                            _controller.controllerSearchGoing,
                        icon: Icons.radio_button_on,
                        controllerSearch: _controller,
                      ),
                      const SizedBox(height: 25),
                      TextFieldIconWidget(
                        controllerSearchDestination:
                            _controller.controllerSearchDestination,
                        icon: Icons.location_on,
                        controllerSearch: _controller,
                      ),
                      const SizedBox(height: 25),
                      AnimatedBuilder(
                          animation: _controller.reload,
                          builder: (context, w) {
                            return !_controller.reload.value
                                ? const Center(
                                    child: Text(
                                        'Buscar endereço'),
                                  )
                                : map();
                          })
                    ],
                  ),
                  ButtonWidget(
                    callbackAction: () {
                      _controller.getPolyPoitns();
                    },
                    icon: Icons.route,
                    labelText: 'Buscar',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox map() {
    return SizedBox(
      height: 350.h,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _controller.currentLocation!.latitude!,
            _controller.currentLocation!.longitude!,
          ),
          zoom: 13.5,
        ),
        polylines: {
          Polyline(
              polylineId: const PolylineId('route'),
              points: _controller.polylineCoordinates,
              color: Colors.orange,
              width: 6),
        },
        markers: _controller.markers,
        onMapCreated: (mapController) {
          _controller.controllerGoogleMaps.complete(mapController);
        },
      ),
    );
  }
}
