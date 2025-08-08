abstract class HomeEvent {}

class HomeLoadEvent extends HomeEvent {
  final int page;

  HomeLoadEvent({this.page = 1});
}