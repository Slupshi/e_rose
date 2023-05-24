import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/address.dart';
import 'package:e_rose/models/hazard_model.dart';
import 'package:e_rose/models/hero.dart';
import 'package:e_rose/models/repositories/accident_type_repository.dart';
import 'package:e_rose/models/repositories/hazard_repository.dart';
import 'package:e_rose/models/repositories/hero_repository.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hazard_declaration_controller.g.dart';
part 'hazard_declaration_controller.freezed.dart';

@freezed
class HazardDeclarationState with _$HazardDeclarationState {
  const factory HazardDeclarationState({
    required List<AccidentTypeModel> accidentTypes,
    required List<HeroModel> heroes,
    required List<HeroModel> possibleHeroes,
    AccidentTypeModel? selectedAccidentType,
    LatLng? selectedPos,
    Address? selectedAddress,
  }) = _HazardDeclarationState;
}

@riverpod
class HazardDeclarationController extends _$HazardDeclarationController {
  @override
  FutureOr<HazardDeclarationState> build() async {
    final accidentTypes =
        await ref.read(accidentTypeRepositoryProvider).getAccidentTypes();
    accidentTypes.sort((a, b) => a.id.compareTo(b.id));
    final heroes = await ref.read(heroRepositoryProvider).getHeroes();
    if (state.value?.selectedPos != null) {}
    return HazardDeclarationState(
      accidentTypes: accidentTypes,
      heroes: heroes,
      possibleHeroes: heroes,
    );
  }

  void selectAccidentType(AccidentTypeModel accidentType) => state = AsyncData(
        state.value!.copyWith(
          selectedAccidentType: accidentType,
          possibleHeroes: [
            ...state.value!.heroes
                .where((hero) => hero.accidentTypes!.any((heroAccidentType) =>
                    heroAccidentType.name == accidentType.name))
                .toList()
          ],
        ),
      );

  Future<void> selectMapPoint(LatLng pos) async {
    final address = await GeoLocatorService.getAddressFromPos(pos);
    state = AsyncData(
      state.value!.copyWith(
        selectedPos: pos,
        selectedAddress: address,
      ),
    );
  }

  Future<LatLng?> selectPointFromAddress(String address) async {
    final pos = await GeoLocatorService.getPosFromAddress(address);
    state = AsyncData(state.value!.copyWith(selectedPos: pos));
    return pos;
  }

  Future<bool> declareHazard(HazardModel model) async {
    try {
      await ref.read(hazardRepositoryProvider).postHazard(model);
      return true;
    } catch (e) {
      return false;
    }
  }

  double? getDistance(HeroModel hero, LatLng? pos) {
    if (pos != null) {
      final double distance = GeoLocatorService.calculateDistance(
        pos.latitude,
        pos.longitude,
        hero.latitude,
        hero.longitude,
      );
      return double.parse((distance / 1000).toStringAsFixed(2));
    }
    return null;
  }
}
