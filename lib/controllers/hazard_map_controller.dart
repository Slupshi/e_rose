import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/city_polygon_model.dart';
import 'package:e_rose/models/hazard_model.dart';
import 'package:e_rose/models/hero_model.dart';
import 'package:e_rose/models/repositories/accident_type_repository.dart';
import 'package:e_rose/models/repositories/hazard_repository.dart';
import 'package:e_rose/models/repositories/hero_repository.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hazard_map_controller.g.dart';
part 'hazard_map_controller.freezed.dart';

@freezed
class HazardMapState with _$HazardMapState {
  const factory HazardMapState({
    required List<AccidentTypeModel> accidentsTypes,
    AccidentTypeModel? selectedAccidentType,
    String? query,
    required List<HazardModel> hazards,
    required List<HazardModel> displayedHazards,
    LatLng? initialPosition,
    CityPolygonModel? selectedCity,
    List<HeroModel>? displayedHeroes,
  }) = _HazardMapState;
}

@riverpod
class HazardMapController extends _$HazardMapController {
  @override
  FutureOr<HazardMapState> build() async {
    final initialPos = await GeoLocatorService.determinePosition();
    LatLng? initialCenter;
    if (initialPos != null) {
      initialCenter = LatLng(initialPos.latitude, initialPos.longitude);
    }
    final List<HazardModel> hazards =
        await ref.read(hazardRepositoryProvider).getHazards();
    final List<AccidentTypeModel> accidents =
        await ref.read(accidentTypeRepositoryProvider).getAccidentTypes();
    return HazardMapState(
      accidentsTypes: accidents,
      hazards: hazards,
      displayedHazards: hazards,
      initialPosition: initialCenter,
    );
  }

  void resetAllFilters() => state = AsyncData(
        state.value!.copyWith(
          displayedHazards: state.value!.hazards,
          selectedAccidentType: null,
          query: null,
          selectedCity: null,
          displayedHeroes: null,
        ),
      );

  void resetAccidentFilter() {
    List<HazardModel> newDisplayedHazards = [];
    if (state.value?.query == null) {
      newDisplayedHazards = [...state.value!.hazards];
    } else {
      newDisplayedHazards = state.value!.hazards
          .where(
            (hazard) => hazard.cityName.toLowerCase().contains(
                  state.value!.query!.toLowerCase(),
                ),
          )
          .toList();
    }
    state = AsyncData(
      state.value!.copyWith(
        displayedHazards: newDisplayedHazards,
        selectedAccidentType: null,
        displayedHeroes: null,
      ),
    );
  }

  void resetQueryFilter() {
    List<HazardModel> newDisplayedHazards = [];
    if (state.value?.selectedAccidentType == null) {
      newDisplayedHazards = [...state.value!.hazards];
    } else {
      newDisplayedHazards = state.value!.hazards
          .where((hazard) =>
              hazard.accidentType.id == state.value!.selectedAccidentType!.id)
          .toList();
    }
    state = AsyncData(
      state.value!.copyWith(
        displayedHazards: newDisplayedHazards,
        query: null,
        selectedCity: null,
        displayedHeroes: null,
      ),
    );
  }

  void selectAccident(AccidentTypeModel accidentType) {
    List<HazardModel> newDisplayedHazards = [];
    if (state.value?.query == null) {
      newDisplayedHazards = state.value!.hazards
          .where((hazard) => hazard.accidentType.id == accidentType.id)
          .toList();
    } else {
      newDisplayedHazards = state.value!.hazards
          .where(
            (hazard) =>
                hazard.accidentType.id == accidentType.id &&
                hazard.cityName.toLowerCase().contains(
                      state.value!.query!.toLowerCase(),
                    ),
          )
          .toList();
    }
    state = AsyncData(
      state.value!.copyWith(
        selectedAccidentType: accidentType,
        displayedHazards: newDisplayedHazards,
      ),
    );
  }

  Future<CityPolygonModel?> search(String query) async {
    if (query.isNotEmpty) {
      final CityPolygonModel? cityPolygon =
          await GeoLocatorService.getGeoJsonByCityName(query);

      List<HeroModel>? displayedHeroes;
      List<HeroModel>? heroes;

      if (cityPolygon != null) {
        displayedHeroes = [];
        heroes = await ref.read(heroRepositoryProvider).getHeroes();
      }
      List<HazardModel> newDisplayedHazards = [];
      if (state.value?.selectedAccidentType == null) {
        newDisplayedHazards = state.value!.hazards
            .where((hazard) => hazard.cityName
                .toLowerCase()
                .contains(cityPolygon!.cityName!.toLowerCase()))
            .toList();
        if (heroes != null && heroes.isNotEmpty) {
          for (var hero in heroes) {
            final toto = hero.accidentTypes!
                .toSet()
                .intersection(
                    newDisplayedHazards.map((e) => e.accidentType).toSet())
                .toList();
            if (toto.isNotEmpty) {
              displayedHeroes!.add(hero);
            }
          }
        }
      } else {
        newDisplayedHazards = state.value!.hazards
            .where(
              (hazard) =>
                  hazard.accidentType.id ==
                      state.value!.selectedAccidentType!.id &&
                  hazard.accidentType.name ==
                      state.value!.selectedAccidentType!.name &&
                  hazard.cityName.toLowerCase().contains(
                        cityPolygon!.cityName!.toLowerCase(),
                      ),
            )
            .toList();
      }
      state = AsyncData(
        state.value!.copyWith(
          query: cityPolygon?.cityName,
          displayedHazards: newDisplayedHazards,
          selectedCity: cityPolygon,
          displayedHeroes: displayedHeroes,
        ),
      );
      return cityPolygon;
    }
    return null;
  }

  Future<List<HeroModel>> getHazardHeroes(
      AccidentTypeModel accidentType) async {
    return (await ref.read(heroRepositoryProvider).getHeroes())
        .where((hero) => hero.accidentTypes!.any(
            (heroAccidentType) => heroAccidentType.name == accidentType.name))
        .toList();
  }

  bool canDisplayedHero(CityPolygonModel city, HeroModel hero) {
    final distance = GeoLocatorService.calculateDistance(
      city.center.latitude,
      city.center.longitude,
      hero.latitude,
      hero.longitude,
    );
    return distance < 50000;
  }
}
