import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  String responseCode;
  String responseMessage;

  ErrorModel({this.responseCode = '-1', this.responseMessage = ''});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
