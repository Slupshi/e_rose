import 'package:e_rose/models/accident.dart';
import 'package:e_rose/models/declaration.dart';
import 'package:e_rose/models/hero.dart';
import 'package:e_rose/models/repositories/accident_repository.dart';
import 'package:e_rose/models/repositories/declaration_repository.dart';
import 'package:e_rose/models/repositories/hero_repository.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'declaration_controller.g.dart';
part 'declaration_controller.freezed.dart';

@freezed
class DeclarationState with _$DeclarationState {
  const factory DeclarationState({
    required List<Accident> accidents,
    required List<HeroModel> heroes,
    required List<HeroModel> possibleHeroes,
    Accident? selectedAccident,
    LatLng? selectedPos,
    String? selectedAddress,
  }) = _DeclarationState;
}

@riverpod
class DeclarationController extends _$DeclarationController {
  @override
  FutureOr<DeclarationState> build() async {
    final accidents = await ref.read(accidentRepositoryProvider).getAccidents();
    accidents.sort((a, b) => a.id.compareTo(b.id));
    final heroes = await ref.read(heroRepositoryProvider).getHeroes();
    if (state.value?.selectedPos != null) {}
    return DeclarationState(
      accidents: accidents,
      heroes: heroes,
      possibleHeroes: heroes,
    );
  }

  void selectAccident(Accident accident) =>
      state = AsyncData(state.value!.copyWith(
        selectedAccident: accident,
        possibleHeroes: [
          ...state.value!.heroes
              .where((hero) => hero.accidents!
                  .any((heroAccident) => heroAccident.name == accident.name))
              .toList()
        ],
      ));

  Future<void> selectMapPoint(LatLng pos) async {
    final address = await GeoLocatorService.getAddressFromPos(pos);
    state = AsyncData(state.value!.copyWith(
      selectedPos: pos,
      selectedAddress: address,
    ));
  }

  Future<bool> declareAccident(DeclarationModel model) async {
    try {
      await ref.read(declarationRepositoryProvider).postDeclaration(model);
      return true;
    } catch (e) {
      return false;
    }
  }

  double? getDistance(HeroModel hero) {
    if (state.value?.selectedPos != null) {
      final double distance = GeoLocatorService.calculateDistance(
        state.value!.selectedPos!.latitude,
        state.value!.selectedPos!.longitude,
        hero.latitude,
        hero.longitude,
      );
      return double.parse((distance / 1000).toStringAsFixed(2));
    }
    return null;
  }
}
