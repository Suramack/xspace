import 'package:flutter/material.dart';
import 'package:xspace/themes/colors.dart';

class ValueAndHeadingWidget extends StatelessWidget {
  final String value, title;
  const ValueAndHeadingWidget({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontSize: 14,
              ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.grey,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}
