import 'package:freezed_annotation/freezed_annotation.dart';

part 'accident_type_model.freezed.dart';
part 'accident_type_model.g.dart';

@freezed
class AccidentTypeModel with _$AccidentTypeModel {
  const factory AccidentTypeModel({
    required int id,
    required String? name,
    required String? description,
    required String? iconCode,
    required String? iconFontFamily,
    required String? iconFontPackage,
  }) = _AccidentTypeModel;

  factory AccidentTypeModel.fromJson(Map<String, Object?> json) =>
      _$AccidentTypeModelFromJson(json);
}
