import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xspace/bloc/news_bloc.dart';
import 'package:xspace/core/models/rocket_list_response_model.dart.dart';
import 'package:xspace/resources/strings.dart';
import 'package:xspace/routes/routes.dart';
import 'package:xspace/themes/colors.dart';
import 'package:xspace/utils/navigations.dart';
import 'package:xspace/utils/utils.dart';
import 'package:xspace/widgets/common/containers/dot_widget.dart';
import 'package:xspace/widgets/common/containers/free_space_widget.dart';
import 'package:xspace/widgets/common/loading_overlay/loading_overlay.dart';

class RocketListScreen extends StatefulWidget {
  const RocketListScreen({super.key});

  @override
  State<RocketListScreen> createState() => _RocketListScreenState();
}

class _RocketListScreenState extends State<RocketListScreen> {
  @override
  void initState() {
    _rocketBloc = BlocProvider.of<RocketBloc>(context, listen: false);
    fetchData();
    super.initState();
  }

  late RocketBloc _rocketBloc;

  List<RocketListResponseModel> rocketListResponseModel = [];

  bool isLoading = false;

  List<Color> cardColorList = [
    AppColors.dark1,
    AppColors.dark2,
    AppColors.dark3,
    AppColors.dark4,
    AppColors.dark5,
  ];
  fetchData() {
    _rocketBloc.add(GetRocketListEvent());
  }

  retry() {
    _rocketBloc.add(GetRocketListEvent());
  }

  void rocketCardOnTap(String id) {
    Navigation.pushNamed(
        context, Routes.rocketDetailsScreen, {"rocket_id": id});
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
        } else if (state is RocketListState) {
          isLoading = false;
          rocketListResponseModel = state.rocketListResponseModel;
        } else {
          isLoading = false;
        }
      },
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return isLoading
            ? const LoadingOverlay()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  itemCount: rocketListResponseModel.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      rocketCardOnTap(rocketListResponseModel[index].id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.dark3,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Utils.screenSize(context).width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rocketListResponseModel[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColors.white,
                                              fontSize: 16,
                                            ),
                                      ),
                                      const VerticalSpace(height: 3),
                                      Text(
                                        rocketListResponseModel[index]
                                            .description,
                                        maxLines: 3,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColors.white,
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                      const VerticalSpace(height: 3),
                                      Text(
                                        rocketListResponseModel[index].country,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColors.white,
                                              fontSize: 12,
                                            ),
                                      ),
                                      const VerticalSpace(height: 10),
                                      Text(
                                        rocketListResponseModel[index].company,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColors.goldyellow,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: DotWidget(
                              color: rocketListResponseModel[index].active
                                  ? AppColors.green
                                  : AppColors.red,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 18,
                            bottom: 16,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 130,
                                  height: 130,
                                  child: PageView.builder(
                                    itemCount: rocketListResponseModel[index]
                                        .flickrImages
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, pageIndex) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Opacity(
                                        opacity: 0.7,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              rocketListResponseModel[index]
                                                  .flickrImages[pageIndex],
                                          placeholder: (context, url) =>
                                              const LoadingOverlay(),
                                          errorWidget: (context, url, error) =>
                                              ErrorWidget(
                                            Strings.pleaseTryAgain,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              );
      },
    );
  }
}
