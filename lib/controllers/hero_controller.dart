import 'package:e_rose/models/hero_model.dart';
import 'package:e_rose/models/repositories/hero_repository.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hero_controller.g.dart';
part 'hero_controller.freezed.dart';

@freezed
class HeroState with _$HeroState {
  const factory HeroState({
    required List<HeroModel> heroes,
    required HeroModel? selectedhero,
    required Position? userPosition,
  }) = _HeroState;
}

@riverpod
class HeroController extends _$HeroController {
  @override
  FutureOr<HeroState> build() async {
    try {
      final pos = await GeoLocatorService.determinePosition();
      final heroes = await ref.read(heroRepositoryProvider).getHeroes();
      return HeroState(
        heroes: heroes,
        selectedhero: heroes.isNotEmpty ? heroes.first : null,
        userPosition: pos,
      );
    } catch (e) {
      return const HeroState(
        heroes: [],
        selectedhero: null,
        userPosition: null,
      );
    }
  }

  String? getDistance(HeroModel hero) {
    if (state.value?.userPosition != null) {
      final double distance = GeoLocatorService.calculateDistance(
        state.value!.userPosition!.latitude,
        state.value!.userPosition!.longitude,
        hero.latitude,
        hero.longitude,
      );
      if (distance > 10000) {
        return "${(distance / 1000).toStringAsFixed(0)} Km";
      } else if (distance > 1000) {
        return "${(distance / 1000).toStringAsFixed(2)} Km";
      } else {
        return "${distance.toStringAsFixed(2)} m";
      }
    }
    return null;
  }

  void select(HeroModel hero) {
    state = AsyncData(
      state.value!.copyWith(selectedhero: hero),
    );
  }
}
