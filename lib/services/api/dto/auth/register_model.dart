import 'package:e_rose/models/accident.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_model.freezed.dart';
part 'register_model.g.dart';

@freezed
class RegisterModel with _$RegisterModel {
  const factory RegisterModel({
    required String heroName,
    required String email,
    required String phoneNumber,
    required String password,
    required double latitude,
    required double longitude,
    required List<Accident> accidents,
  }) = _RegisterModel;

  factory RegisterModel.fromJson(Map<String, Object?> json) =>
      _$RegisterModelFromJson(json);
}
