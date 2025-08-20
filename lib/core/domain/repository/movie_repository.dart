import 'package:flutter_moviedb/core/domain/entity/movie/movie_detail.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie_list.dart';

abstract class MovieRepository {
  Future<MovieList> getPopularMovies(int page);
  Future<MovieList> getTopRatedMovies(int page);
  Future<MovieList> getUpcomingMovies(int page);
  Future<MovieList> getNowPlayingMovies(int page);
  Future<MovieList> searchMovies(String query, int page);
  Future<MovieDetail> getMovieDetail(int movieId);
}