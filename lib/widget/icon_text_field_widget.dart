import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../components/constants.dart';
import '../controller/search_address_controller.dart';

// ignore: must_be_immutable
class IconTextFieldCustomWidget extends StatefulWidget {
  IconData icon;
  TextEditingController controllerSearchGoing;
  SearchAddressController controllerSearch;

  IconTextFieldCustomWidget(
      {super.key,
      required this.icon,
      required this.controllerSearch,
      required this.controllerSearchGoing});

  @override
  State<IconTextFieldCustomWidget> createState() =>
      _IconTextFieldCustomWidgetState();
}

class _IconTextFieldCustomWidgetState extends State<IconTextFieldCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          InkWell(
              onTap: () => widget.controllerSearchGoing.clear(),
              child: Icon(widget.icon)),
          SizedBox(width: 15.h),
          SizedBox(
            width: 300.w,
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: widget.controllerSearchGoing,
              googleAPIKey: google_api_key,
              textStyle: const TextStyle(color: Colors.black),
              inputDecoration: InputDecoration(
                hintText: 'Digite o endereço de origem',
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
                widget.controllerSearch.latGoing = double.parse(prediction.lat!.toString());
                widget.controllerSearch.logGoing = double.parse(prediction.lng!.toString());
              },
              itmClick: (Prediction prediction) {
                widget.controllerSearchGoing.text = prediction.description!;
                widget.controllerSearchGoing.selection =
                    TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length));
              },
            ),
          ),
        ],
      ),
    );
  }
}
