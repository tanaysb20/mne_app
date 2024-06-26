import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DropdownInput extends StatelessWidget {
  final String? inputName;
  final TextEditingController? controller;
  final dynamic value;
  final String labelText;
  final double? inputLabelWidth;
  String? Function(dynamic)? validatorsss;
  final double? inputFieldWidth;
  final bool? isEnabled;
  final bool? isMargin;
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;

  DropdownInput({
    Key? key,
    this.inputName,
    this.labelText = "",
    this.controller,
    this.value,
    this.inputLabelWidth,
    this.validatorsss,
    this.inputFieldWidth,
    this.isEnabled,
    this.items,
    this.onChanged,
    this.isMargin = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isEnabled == true ? Colors.white : Colors.black,
      margin: EdgeInsets.zero,
      child: DropdownButtonFormField(
        isExpanded: true,
        focusNode: FocusNode(canRequestFocus: false),
        validator: validatorsss,
        items: items,
        onChanged: isEnabled == true ? onChanged : null,
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 23.sp,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: value.toString(),
          hintStyle: textFieldStyle1111(color: Colors.black, fontSize: 22.sp),
          border: defaultBorderTextField1111(),
          focusedBorder: defaultBorderTextField1111(),
          enabledBorder: defaultBorderTextField1111(),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
          isCollapsed: true,
        ),
      ),
    );
  }
}

TextStyle textFieldStyle1111(
        {double fontSize = 20,
        FontWeight weight = FontWeight.w400,
        FontStyle style = FontStyle.normal,
        bool isHint = false,
        Color color = Colors.black}) =>
    TextStyle(
      color: color,
      fontFamily: "Inter",
      fontSize: fontSize.sp,
      fontWeight: weight,
    );

defaultBorderTextField1111({bool fill = false}) => OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue.shade900,
    ),
    borderRadius: BorderRadius.circular(8));
TextStyle customStyle = TextStyle(
  color: Colors.black,
  fontFamily: "Inter",
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
);
