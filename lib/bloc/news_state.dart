part of 'news_bloc.dart';

@immutable
abstract class RocketState extends Equatable {}

class RocketLoadingState extends RocketState {
  @override
  List<Object?> get props => [];
}

class RocketErrorState extends RocketState {
  final dynamic error;
  RocketErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class RocketListState extends RocketState {
  final List<RocketListResponseModel> rocketListResponseModel;
  RocketListState(this.rocketListResponseModel);
  @override
  List<Object?> get props => [rocketListResponseModel];
}

class RocketDetailsState extends RocketState {
  final RocketDetailsResponseModel rocketDetailsResponseModel;
  RocketDetailsState(this.rocketDetailsResponseModel);
  @override
  List<Object?> get props => [rocketDetailsResponseModel];
}
