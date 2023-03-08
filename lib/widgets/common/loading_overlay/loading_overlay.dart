import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xspace/resources/lottie_file.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({super.key});

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        LottieFiles.loading,
        width: 150,
      ),
    );
  }
}
