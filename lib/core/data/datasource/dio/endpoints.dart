import 'package:dio/dio.dart';

class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://api.themoviedb.org/3/';

  static Options acceptJsonHeader = Options(
    headers: {
      'Accept': 'application/json',
    },
  );

  static const int receiveTimeout = 15000;
  static const int connectTimeout = 15000;

  static const String nowPlayingMovies= 'movie/now_playing';
  static const String popularMovies = 'movie/popular';
  static const String topRatedMovies = 'movie/top_rated';
  static const String upcomingMovies = 'movie/upcoming';
}