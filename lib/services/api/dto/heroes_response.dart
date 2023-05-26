import 'package:e_rose/models/hero_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'heroes_response.freezed.dart';
part 'heroes_response.g.dart';

@freezed
class HeroesResponse with _$HeroesResponse {
  const factory HeroesResponse({
    required List<HeroModel> items,
  }) = _HeroesResponse;

  factory HeroesResponse.fromJson(Map<String, Object?> json) =>
      _$HeroesResponseFromJson(json);
}
