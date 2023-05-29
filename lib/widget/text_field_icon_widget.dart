import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../components/constants.dart';
import '../controller/search_address_controller.dart';

// ignore: must_be_immutable
class TextFieldIconWidget extends StatefulWidget {
  IconData icon;
  TextEditingController controllerSearchDestination;
  SearchAddressController controllerSearch;
  TextFieldIconWidget(
      {super.key,
      required this.icon,
      required this.controllerSearch,
      required this.controllerSearchDestination});

  @override
  State<TextFieldIconWidget> createState() => _TextFieldIconWidgetState();
}

class _TextFieldIconWidgetState extends State<TextFieldIconWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          SizedBox(
            width: 300.w,
            child: GooglePlaceAutoCompleteTextField(
                textEditingController: widget.controllerSearchDestination,
                googleAPIKey: google_api_key,
                textStyle: const TextStyle(color: Colors.black),
                inputDecoration: InputDecoration(
                  hintText: 'Digite o endereço de destino',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                debounceTime: 600,
                countries: const ["pt", "br"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (Prediction prediction) {
                  widget.controllerSearch.latDestination =
                      double.parse(prediction.lat!.toString());
                  widget.controllerSearch.logDestination =
                      double.parse(prediction.lng!.toString());
                },
                itmClick: (Prediction prediction) {
                  widget.controllerSearchDestination.text =
                      prediction.description!;
                  widget.controllerSearchDestination.selection =
                      TextSelection.fromPosition(
                          TextPosition(offset: prediction.description!.length));
                }),
          ),
          const SizedBox(width: 15),
          InkWell(
              onTap: () => widget.controllerSearchDestination.clear(),
              child: Icon(widget.icon)),
        ],
      ),
    );
  }
}
