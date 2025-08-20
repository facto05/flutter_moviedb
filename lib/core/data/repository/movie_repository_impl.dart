import 'package:flutter_moviedb/core/data/datasource/service/movie_service.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie_detail.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie_list.dart';
import 'package:flutter_moviedb/core/domain/repository/movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  MovieService movieService;

  MovieRepositoryImpl(this.movieService);
  
  @override
  Future<MovieList> getNowPlayingMovies(int page) async {
    final response = await movieService.getNowPlayingMovies(page);
    return response.toEntity();
  }
  
  @override
  Future<MovieList> getPopularMovies(int page) async {
    final response = await movieService.getPopularMovies(page);
    return response.toEntity();
  }
  
  @override
  Future<MovieList> getTopRatedMovies(int page) async {
    final response = await movieService.getTopRatedMovies(page);
    return response.toEntity();
  }
  
  @override
  Future<MovieList> getUpcomingMovies(int page) async {
    final response = await movieService.getUpcomingMovies(page);
    return response.toEntity();
  }
  
  @override
  Future<MovieList> searchMovies(String query, int page) async {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieId) async {
    final response = await movieService.getMovieDetail(movieId);
    return response.toEntity();
  }
  
}
