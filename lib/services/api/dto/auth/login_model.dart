import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginModel with _$LoginModel {
  const factory LoginModel({
    required String email,
    required String password,
  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, Object?> json) =>
      _$LoginModelFromJson(json);
}
