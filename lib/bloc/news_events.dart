part of 'news_bloc.dart';

abstract class RocketEvents extends Equatable {}

class GetRocketListEvent extends RocketEvents {
  @override
  List<Object?> get props => [];
}

class GetRocketDetailsEvent extends RocketEvents {
  final String rocketId;
  GetRocketDetailsEvent(this.rocketId);
  @override
  List<Object?> get props => [rocketId];
}
