import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';

var kTorqueiseElevatedButtonSytle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(kTorqueiseBackgroundColor),
  padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
);

var kTitleBoldTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

var kTitleWhiteTextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
