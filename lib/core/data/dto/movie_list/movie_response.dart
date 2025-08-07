import 'package:flutter_moviedb/core/data/dto/movie_list/dates.dart';
import 'package:flutter_moviedb/core/data/dto/movie_list/result.dart';

class MovieResponse {
  final Dates? dates;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  MovieResponse({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      dates: json['dates'] != null
          ? Dates.fromJson(json['dates'] as Map<String, dynamic>)
          : null,
      page: json['page'],
      results: (json['results'] as List)
          .map((movie) => Result.fromJson(movie))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}