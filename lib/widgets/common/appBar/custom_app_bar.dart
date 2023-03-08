import 'package:flutter/material.dart';
import 'package:xspace/themes/colors.dart';
import 'package:xspace/utils/navigations.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;
  final dynamic icon;
  final Color? iconColor;
  final double iconSize;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor = AppColors.transparent,
    this.iconSize = 24,
    this.icon = Icons.arrow_back,
    this.iconColor,
  });

  static void goBack(BuildContext context) {
    Navigation.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
