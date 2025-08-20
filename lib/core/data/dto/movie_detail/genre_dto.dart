import 'package:flutter_moviedb/core/domain/entity/movie/genre.dart';

class GenreDto {
  int? id;
  String? name;

  GenreDto({this.id, this.name});

  factory GenreDto.fromJson(Map<String, dynamic> json) {
    return GenreDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Genre toEntity() {
    return Genre(
      id: id ?? 0,
      name: name ?? '',
    );
  }
}