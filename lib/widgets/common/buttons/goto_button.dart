import 'package:flutter/material.dart';
import 'package:xspace/themes/colors.dart';

class GotoButton extends StatelessWidget {
  final Function onTap;
  final String title;
  const GotoButton({
    super.key, required this.onTap, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>onTap(),
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.black,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.black,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
