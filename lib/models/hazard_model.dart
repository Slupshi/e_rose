import 'package:e_rose/models/accident_type_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hazard_model.g.dart';
part 'hazard_model.freezed.dart';

@freezed
class HazardModel with _$HazardModel {
  const factory HazardModel({
    required String cityName,
    required String description,
    required AccidentTypeModel accidentType,
    required double latitude,
    required double longitude,
    DateTime? createdAt,
  }) = _HazardModel;

  factory HazardModel.fromJson(Map<String, Object?> json) =>
      _$HazardModelFromJson(json);
}
