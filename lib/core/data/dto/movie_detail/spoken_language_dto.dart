import 'package:flutter_moviedb/core/domain/entity/spoken_language.dart';

class SpokenLanguageDto {
  String? iso6391;
  String? name;
  String? englishName;

  SpokenLanguageDto({this.iso6391, this.name, this.englishName});

  factory SpokenLanguageDto.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageDto(
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
      englishName: json['english_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso6391,
      'name': name,
      'english_name': englishName,
    };
  }

  SpokenLanguage toEntity() {
    return SpokenLanguage(
      iso6391: iso6391 ?? '',
      name: name ?? '',
      englishName: englishName ?? '',
    );
  }
}