import 'package:e_rose/models/accident_type_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hero.freezed.dart';
part 'hero.g.dart';

@freezed
class HeroModel with _$HeroModel {
  const factory HeroModel({
    required int id,
    required String heroName,
    required String? firstName,
    required String? lastName,
    required String email,
    required String phoneNumber,
    required double longitude,
    required double latitude,
    int? heroScore,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'accidents') required List<AccidentTypeModel>? accidentTypes,
  }) = _HeroModel;

  factory HeroModel.fromJson(Map<String, Object?> json) =>
      _$HeroModelFromJson(json);
}
