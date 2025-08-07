import 'package:flutter_moviedb/core/domain/entity/movie/movie.dart';
import 'package:flutter_moviedb/core/domain/repository/genre_repository.dart';

class Result {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteCount;
  double? voteAverage;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteCount,
    this.voteAverage,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteCount: (json['vote_count'] as num?)?.toDouble(),
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
    );
  }

  Movie toEntity() {
    return Movie(
      id: id?.toString() ?? '',
      title: title ?? '',
      overview: overview ?? '',
      posterPath: 'https://image.tmdb.org/t/p/w185$posterPath',
      backdropPath: backdropPath ?? '',
      releaseDate: releaseDate ?? '',
      voteAverage: voteAverage ?? 0.0,
      video: video ?? false,
      genres: genreIds?.map((id) => GenreRepository.findGenreById(id).name).toList() ?? [],
    );
  }
}