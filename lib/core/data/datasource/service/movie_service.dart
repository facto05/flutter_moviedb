import 'package:flutter_moviedb/core/data/dto/movie_list/movie_response.dart';

abstract class MovieService {
  Future<MovieResponse> getPopularMovies(int page);
  Future<MovieResponse> getTopRatedMovies(int page);
  Future<MovieResponse> getNowPlayingMovies(int page);
  Future<MovieResponse> getUpcomingMovies(int page);
}