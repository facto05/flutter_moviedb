import 'package:flutter_moviedb/core/domain/entity/production/production_company.dart';

class ProductionCompanyDto {
  int? id;
  String? name;
  String? logoPath;
  String? originCountry;

  ProductionCompanyDto({
    this.id,
    this.name,
    this.logoPath,
    this.originCountry,
  });

  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_path': logoPath,
      'origin_country': originCountry,
    };
  }

  ProductionCompany toEntity() {
    return ProductionCompany(
      id: id ?? 0,
      name: name ?? '',
      logoPath: logoPath ?? '',
      originCountry: originCountry ?? '',
    );
  }
}