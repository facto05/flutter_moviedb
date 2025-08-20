import 'package:flutter_moviedb/core/data/dto/movie_detail/movie_detail_response_dto.dart.dart';
import 'package:flutter_moviedb/core/data/dto/movie_list/movie_response.dart';

abstract class MovieService {
  Future<MovieResponse> getPopularMovies(int page);
  Future<MovieResponse> getTopRatedMovies(int page);
  Future<MovieResponse> getNowPlayingMovies(int page);
  Future<MovieResponse> getUpcomingMovies(int page);
  Future<MovieDetailResponseDto> getMovieDetail(int movieId);
  Future<MovieResponse> searchMovies(String query, int page);
}