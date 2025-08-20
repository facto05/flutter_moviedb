import 'package:flutter_moviedb/core/domain/entity/production/production_country.dart';

class ProductionCountriesDto {
  String? iso31661;
  String? name;

  ProductionCountriesDto({this.iso31661, this.name});

  factory ProductionCountriesDto.fromJson(Map<String, dynamic> json) {
    return ProductionCountriesDto(
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso31661,
      'name': name,
    };
  }

  ProductionCountry toEntity() {
    return ProductionCountry(
      iso31661: iso31661 ?? '',
      name: name ?? '',
    );
  }
}