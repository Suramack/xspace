import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xspace/core/models/rocket_details_response_model.dart';
import 'package:xspace/core/models/rocket_list_response_model.dart.dart';
import 'package:xspace/core/services/rocket/rocket_service.dart';
import 'package:xspace/resources/strings.dart';

part 'news_events.dart';
part 'news_state.dart';

class RocketBloc extends Bloc<RocketEvents, RocketState> {
  final SpaceXService spaceXService;

  RocketBloc({required this.spaceXService}) : super(RocketLoadingState()) {
    on<GetRocketListEvent>(getRocketList);
    on<GetRocketDetailsEvent>(getRocketDetails);
  }

  void getRocketList(GetRocketListEvent event, Emitter emitter) async {
    emitter(RocketLoadingState());

    try {
      emitter(RocketListState(await spaceXService.getRocketList()));
    } on SocketException {
      emitter(RocketErrorState(Strings.noInternetAlert));
    } on HttpException {
      emitter(RocketErrorState(Strings.httpAlert));
    } on FormatException {
      emitter(RocketErrorState(Strings.formatAlert));
    } catch (e) {
      emitter(RocketErrorState(e.toString()));
    }
  }

  void getRocketDetails(GetRocketDetailsEvent event, Emitter emitter) async {
    emitter(RocketLoadingState());
    try {
      emitter(RocketDetailsState(
          await spaceXService.getRocketDetails(event.rocketId)));
    } on SocketException {
      emitter(RocketErrorState(Strings.noInternetAlert));
    } on HttpException {
      emitter(RocketErrorState(Strings.httpAlert));
    } on FormatException {
      emitter(RocketErrorState(Strings.formatAlert));
    } catch (e) {
      emitter(RocketErrorState(e.toString()));
    }
  }
}
