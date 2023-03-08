import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xspace/resources/strings.dart';

class Utils {
  Utils._();
  static String handleExecption(Response response) {
    if (response.statusCode == 404) {
      return Strings.pleaseTryAgain;
    }
    return Strings.pleaseTryAgain;
  }

  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;
}
