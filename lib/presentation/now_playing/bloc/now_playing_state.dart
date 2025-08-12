import 'package:equatable/equatable.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie.dart';


abstract class NowPlayingState extends Equatable {
  final List<Movie> movies;
  final bool hasReachedMax;

  const NowPlayingState({
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [movies, hasReachedMax];
}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingLoaded extends NowPlayingState {
  const NowPlayingLoaded({
    required super.movies,
    required super.hasReachedMax,
  });
}

class NowPlayingError extends NowPlayingState {
  final String message;

  const NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}