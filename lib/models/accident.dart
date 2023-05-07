import 'package:freezed_annotation/freezed_annotation.dart';

part 'accident.freezed.dart';
part 'accident.g.dart';

@freezed
class Accident with _$Accident {
  const factory Accident({
    required int id,
    required String name,
    required String description,
    required int iconCode,
    required String? iconFont,
    required String? iconPackage,
  }) = _Accident;

  factory Accident.fromJson(Map<String, Object?> json) =>
      _$AccidentFromJson(json);
}
