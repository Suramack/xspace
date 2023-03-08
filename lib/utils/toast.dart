import 'package:fluttertoast/fluttertoast.dart';
import 'package:xspace/themes/colors.dart';

showToast(String msg) =>
    Fluttertoast.showToast(msg: msg, backgroundColor: AppColors.primary);
