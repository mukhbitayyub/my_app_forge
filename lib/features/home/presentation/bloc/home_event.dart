import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}

class HomePageChanged extends HomeEvent {
  const HomePageChanged(this.page);
  final int page;

  @override
  List<Object?> get props => [page];
}

class HomeItemBookmarked extends HomeEvent {
  const HomeItemBookmarked(this.itemId);
  final String itemId;

  @override
  List<Object?> get props => [itemId];
}
