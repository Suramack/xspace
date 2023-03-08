import 'package:flutter/material.dart';

import 'package:pigment/pigment.dart';

/// Define all the colors to be used in application in this file
/// To use - import this file and call required string by:
///```dart
///      AppColors.<name>
///```
///For Color Names refer: http://chir.ag/projects/name-that-color/#6195ED
class AppColors {
  AppColors._();

  static final Color lightSilver = Pigment.fromString('#ced9de');
  static const Color transparent = Colors.transparent;
  static final Color white = Pigment.fromString("#ffffff");

  static final Color black = Pigment.fromString('#000000');
  static final Color grey = Pigment.fromString('#969696');
  static final Color goldyellow = Pigment.fromString('#FFD700');

  static final Color primary = Pigment.fromString('#0f1231');
  static final Color primaryDark = Pigment.fromString('#002939');
  static final Color primaryLight = Pigment.fromString('#517d91');
  static final Color dark1 = Pigment.fromString('#101530');
  static final Color dark2 = Pigment.fromString('#0c102b');
  static final Color dark3 = Pigment.fromString('#141a3b');
  static final Color dark4 = Pigment.fromString('#0e122d');
  static final Color dark5 = Pigment.fromString('#111527');
  static final Color red = Pigment.fromString('#FF0000');
  static final Color green = Pigment.fromString('#00FA9A');
}
