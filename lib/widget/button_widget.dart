import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatefulWidget {
  String labelText;
  IconData icon;
  VoidCallback callbackAction;
  double? heightButton;
  double? widthButton;
  Color? colorButton;
  ButtonWidget(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.callbackAction,
      this.heightButton,
      this.widthButton,
      this.colorButton});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: SizedBox(
        height: widget.heightButton ?? 40.h,
        width: widget.widthButton ?? 250.w,
        child: FloatingActionButton.extended(
          backgroundColor: widget.colorButton ?? Colors.orange,
          onPressed: widget.callbackAction,
          icon: Icon(widget.icon),
          label: Text(widget.labelText),
        ),
      ),
    );
  }
}
