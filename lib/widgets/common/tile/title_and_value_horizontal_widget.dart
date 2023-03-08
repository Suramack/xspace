import 'package:flutter/material.dart';
import 'package:xspace/themes/colors.dart';

class TitleValueHorizontalWidget extends StatelessWidget {
  const TitleValueHorizontalWidget({
    required this.title,
    required this.value,
    super.key,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.grey,
                  fontSize: 12,
                ),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.goldyellow,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
