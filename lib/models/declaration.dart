import 'package:e_rose/models/accident.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'declaration.g.dart';
part 'declaration.freezed.dart';

@freezed
class DeclarationModel with _$DeclarationModel {
  const factory DeclarationModel({
    required String cityName,
    required String description,
    required Accident accident,
    required double latitude,
    required double longitude,
  }) = _DeclarationModel;

  factory DeclarationModel.fromJson(Map<String, Object?> json) =>
      _$DeclarationModelFromJson(json);
}
