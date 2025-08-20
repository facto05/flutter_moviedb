import 'package:flutter_moviedb/core/data/dto/movie_detail/genre_dto.dart';
import 'package:flutter_moviedb/core/data/dto/movie_detail/production_company_dto.dart';
import 'package:flutter_moviedb/core/data/dto/movie_detail/production_countries_dto.dart';
import 'package:flutter_moviedb/core/data/dto/movie_detail/spoken_language_dto.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie_detail.dart';

class MovieDetailResponseDto {
  bool? isAdult;
  String? backdropPath;
  String? belongsToCollection;
  int? budget;
  List<GenreDto> genres = [];
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanyDto> productionCompanies = [];
  List<ProductionCountriesDto> productionCountries = [];
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguageDto> spokenLanguages = [];
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieDetailResponseDto({
    this.isAdult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    required this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    required this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video = false,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });

  factory MovieDetailResponseDto.fromJson(Map<String, dynamic> json) {
    return MovieDetailResponseDto(
      isAdult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      belongsToCollection: json['belongs_to_collection'] as String?,
      budget: json['budget'] as int?,
      genres: (json['genres'] as List)
          .map((genre) => GenreDto.fromJson(genre))
          .toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int?,
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List)
          .map((company) => ProductionCompanyDto.fromJson(company))
          .toList(),
      productionCountries: (json['production_countries'] as List)
          .map((country) => ProductionCountriesDto.fromJson(country))
          .toList(),
      releaseDate: json['release_date'] as String?,
      revenue: json['revenue'] as int?,
      runtime: json['runtime'] as int?,
      spokenLanguages: (json['spoken_languages'] as List)
          .map((language) => SpokenLanguageDto.fromJson(language))
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': isAdult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection,
      'budget': budget,
      'genres': genres.map((genre) => genre.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies.map((company) => company.toJson()).toList(),
      'production_countries':
          productionCountries.map((country) => country.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages':
          spokenLanguages.map((language) => language.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  MovieDetail toEntity() {
    return MovieDetail(
      isAdult: isAdult ?? false,
      backdropPath: backdropPath ?? '',
      belongsToCollection: belongsToCollection ?? '',
      budget: budget ?? 0,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      homepage: homepage ?? '',
      id: id ?? 0,
      imdbId: imdbId ?? '',
      originalLanguage: originalLanguage ?? '',
      originalTitle: originalTitle ?? '',
      overview: overview ?? '',
      popularity: popularity ?? 0.0,
      posterPath: posterPath ?? '',
      productionCompanies:
          productionCompanies.map((company) => company.toEntity()).toList(),
      productionCountries:
          productionCountries.map((country) => country.toEntity()).toList(),
      releaseDate: releaseDate ?? '',
      revenue: revenue ?? 0,
      runtime: runtime ?? 0,
      spokenLanguages:
          spokenLanguages.map((language) => language.toEntity()).toList(),
      status: status ?? '',
      tagline: tagline ?? '',
      title: title ?? '',
      video: video ?? false,
      voteAverage: voteAverage ?? 0.0,
      voteCount: voteCount ?? 0,
    );
  }
}