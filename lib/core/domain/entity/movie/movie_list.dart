import 'package:flutter_moviedb/core/domain/entity/movie/movie.dart';

class MovieList {
  final List<Movie> movies;
  final int page;
  final int totalPages;

  MovieList({
    required this.movies,
    required this.page,
    required this.totalPages,
  });
}