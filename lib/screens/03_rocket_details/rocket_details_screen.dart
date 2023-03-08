import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xspace/bloc/news_bloc.dart';
import 'package:xspace/core/models/rocket_details_response_model.dart';
import 'package:xspace/resources/strings.dart';
import 'package:xspace/themes/colors.dart';
import 'package:xspace/utils/toast.dart';
import 'package:xspace/widgets/common/buttons/goto_button.dart';
import 'package:xspace/widgets/common/containers/dot_widget.dart';
import 'package:xspace/widgets/common/containers/free_space_widget.dart';
import 'package:xspace/widgets/common/loading_overlay/loading_overlay.dart';
import 'package:xspace/widgets/common/tile/title_and_value_horizontal_widget.dart';
import 'package:xspace/widgets/common/tile/value_and_title_widget.dart';

class RocketDetailsScreen extends StatefulWidget {
  const RocketDetailsScreen({super.key});

  @override
  State<RocketDetailsScreen> createState() => _RocketDetailsScreenState();
}

class _RocketDetailsScreenState extends State<RocketDetailsScreen> {
  Map args = {};

  late RocketBloc _rocketBloc;

  bool isLoading = false;
  RocketDetailsResponseModel? rocketDetailsResponseModel;

  @override
  void initState() {
    _rocketBloc = BlocProvider.of<RocketBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ModalRoute.of(context) == null) {
        args = {};
      } else if (ModalRoute.of(context)!.settings.arguments == null) {
        args = {};
      } else {
        args = ModalRoute.of(context)!.settings.arguments as Map;
      }
      fetchData();
    });

    super.initState();
  }

  void fetchData() async {
    if (args.isNotEmpty && args["rocket_id"] != null) {
      _rocketBloc.add(GetRocketDetailsEvent(args["rocket_id"]));
    }
  }

  gotoWeb(String url) async {
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _rocketBloc,
      listener: (context, state) {
        if (state is RocketLoadingState) {
          isLoading = true;
        } else if (state is RocketErrorState) {
          isLoading = false;
          showToast(state.error);
        } else if (state is RocketDetailsState) {
          rocketDetailsResponseModel = state.rocketDetailsResponseModel;
          isLoading = false;
        }
      },
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return rocketDetailsResponseModel == null
            ? const LoadingOverlay()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpace(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rocketDetailsResponseModel!.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.white,
                                  fontSize: 18,
                                ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showToast(
                                rocketDetailsResponseModel!.active
                                    ? Strings.active
                                    : Strings.inActive,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Strings.active,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppColors.white,
                                            fontSize: 12,
                                          ),
                                    ),
                                    const HorizontalSpace(width: 12),
                                    DotWidget(
                                      color: rocketDetailsResponseModel!.active
                                          ? AppColors.green
                                          : AppColors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpace(height: 20),
                      CarouselSlider.builder(
                        itemCount:
                            rocketDetailsResponseModel!.flickrImages.length,
                        itemBuilder: (context, index, realIndex) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl:
                                rocketDetailsResponseModel!.flickrImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        options: CarouselOptions(
                          autoPlay: true,
                        ),
                      ),
                      const VerticalSpace(height: 20),
                      Row(
                        children: [
                          ValueAndHeadingWidget(
                            value:
                                '${rocketDetailsResponseModel!.height.feet}/${rocketDetailsResponseModel!.height.meters}',
                            title: Strings.height,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 1,
                              height: 25,
                              decoration: BoxDecoration(
                                color: AppColors.goldyellow,
                              ),
                            ),
                          ),
                          ValueAndHeadingWidget(
                            value:
                                '${rocketDetailsResponseModel!.diameter.feet}/${rocketDetailsResponseModel!.diameter.meters}',
                            title: Strings.diameter,
                          ),
                        ],
                      ),
                      const VerticalSpace(height: 20),
                      TitleValueHorizontalWidget(
                        title: '${Strings.cost}: ',
                        value: '${rocketDetailsResponseModel!.costPerLaunch}',
                      ),
                      TitleValueHorizontalWidget(
                        title: '${Strings.successRate}: ',
                        value: '${rocketDetailsResponseModel!.successRatePct}%',
                      ),
                      const VerticalSpace(height: 10),
                      Text(
                        rocketDetailsResponseModel!.description,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                      ),
                      const VerticalSpace(height: 20),
                      GotoButton(
                        onTap: () {
                          gotoWeb(rocketDetailsResponseModel!.wikipedia);
                        },
                        title: Strings.more,
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
