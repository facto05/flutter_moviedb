import 'package:flutter_moviedb/core/data/datasource/dio/endpoints.dart';
import 'package:flutter_moviedb/core/data/datasource/dio/network_provider.dart';
import 'package:flutter_moviedb/core/data/datasource/service/movie_service.dart';
import 'package:flutter_moviedb/core/data/dto/movie_list/movie_response.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: MovieService)
class MovieServiceImpl implements MovieService {
  NetworkProviderDio networkProviderDio;

  MovieServiceImpl({required this.networkProviderDio});

  @override
  Future<MovieResponse> getNowPlayingMovies(int page) async {
    final response = await networkProviderDio.get(
      Endpoints.nowPlayingMovies,
      queryParameters: {'page': page},
    );
    return MovieResponse.fromJson(response.data);
  }

  @override
  Future<MovieResponse> getPopularMovies(int page) async {
    final response = await networkProviderDio.get(
      Endpoints.popularMovies,
      queryParameters: {'page': page},
    );
    return MovieResponse.fromJson(response.data);
  }

  @override
  Future<MovieResponse> getTopRatedMovies(int page) async {
    final response = await networkProviderDio.get(
      Endpoints.topRatedMovies,
      queryParameters: {'page': page},
    );
    return MovieResponse.fromJson(response.data);
  }

  @override
  Future<MovieResponse> getUpcomingMovies(int page) async {
    final response = await networkProviderDio.get(
      Endpoints.upcomingMovies,
      queryParameters: {'page': page},
    );
    return MovieResponse.fromJson(response.data);
  }
}
