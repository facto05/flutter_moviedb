import 'package:flutter_moviedb/core/domain/entity/movie/movie_list.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final MovieList nowPlayingMovies;
  final MovieList popularMovies;
  final MovieList topRatedMovies;
  final MovieList upcomingMovies;

  HomeLoaded({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });
}