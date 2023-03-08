import 'dart:async' show runZoned;
import 'package:flutter/material.dart';
import 'package:xspace/app.dart';

void main() async {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  });
}
