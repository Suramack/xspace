import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:xspace/bloc/news_bloc.dart';
import 'package:xspace/resources/lottie_file.dart';
import 'package:xspace/resources/strings.dart';
import 'package:xspace/routes/routes.dart';
import 'package:xspace/themes/colors.dart';
import 'package:xspace/utils/toast.dart';
import 'package:xspace/utils/utils.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  void initState() {
    _rocketBloc = BlocProvider.of<RocketBloc>(context, listen: false);
    super.initState();
  }

  late RocketBloc _rocketBloc;

  Future<void> gotoRokcetScreen() async {
    Navigator.pushReplacementNamed(
      context,
      Routes.rocketListScreen,
    );
  }

  double rocketBottomPosition = 100;

  bool isHideGetStartedButton = false;

  double titleOpacity = 1.0;

  void changeRocketPostion() {
    _rocketBloc.add(GetRocketListEvent());
    rocketBottomPosition = Utils.screenSize(context).height;
    isHideGetStartedButton = true;
    titleOpacity = 0.0;
    setState(() {});
  }

  void retry() {
    showToast(Strings.pleaseTryAgain);
    rocketBottomPosition = 100;

    isHideGetStartedButton = false;

    titleOpacity = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _rocketBloc,
      listener: (context, state) {
        if (state is RocketLoadingState) {
        } else if (state is RocketErrorState) {
          retry();
        } else if (state is RocketListState) {
          gotoRokcetScreen();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: Utils.screenSize(context).width * 0.3,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: titleOpacity,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.rocketLaunch,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.white,
                                  fontSize: 24,
                                ),
                          ),
                          TextSpan(
                            text: ' ${Strings.rocket} .',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.goldyellow,
                                  fontSize: 24,
                                  backgroundColor: AppColors.black,
                                ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 600),
              left: 0,
              right: 0,
              bottom: rocketBottomPosition,
              child: Center(
                child: LottieBuilder.asset(
                  LottieFiles.splash,
                  height: Utils.screenSize(context).width * 0.8,
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    changeRocketPostion();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.black,
                    ),
                    child: isHideGetStartedButton
                        ? const SizedBox()
                        : Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      Strings.getStarted,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
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
                ),
              ),
            ),
            isHideGetStartedButton
                ? Positioned(
                    bottom: -20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: LottieBuilder.asset(
                        LottieFiles.loading,
                        height: 150,
                      ),
                    ),
                  )
                : const Positioned(
                    left: 0,
                    right: 0,
                    child: SizedBox(),
                  )
          ],
        );
      },
    );
  }
}
