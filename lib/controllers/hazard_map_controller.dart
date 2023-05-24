import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/hazard_model.dart';
import 'package:e_rose/models/repositories/accident_type_repository.dart';
import 'package:e_rose/models/repositories/hazard_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
  }) = _HazardMapState;
}

@riverpod
class HazardMapController extends _$HazardMapController {
  @override
  FutureOr<HazardMapState> build() async {
    final List<HazardModel> hazards =
        await ref.read(hazardRepositoryProvider).getHazards();
    final List<AccidentTypeModel> accidents =
        await ref.read(accidentTypeRepositoryProvider).getAccidentTypes();
    return HazardMapState(
      accidentsTypes: accidents,
      hazards: hazards,
      displayedHazards: hazards,
    );
  }

  void resetAllFilters() => state = AsyncData(
        state.value!.copyWith(
          displayedHazards: state.value!.hazards,
          selectedAccidentType: null,
          query: null,
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
              hazard.accidentType.name ==
              state.value!.selectedAccidentType!.name)
          .toList();
    }
    state = AsyncData(
      state.value!.copyWith(
        displayedHazards: newDisplayedHazards,
        query: null,
      ),
    );
  }

  void selectAccident(AccidentTypeModel accidentType) {
    List<HazardModel> newDisplayedHazards = [];
    if (state.value?.query == null) {
      newDisplayedHazards = state.value!.hazards
          .where((hazard) => hazard.accidentType.name == accidentType.name)
          .toList();
    } else {
      newDisplayedHazards = state.value!.hazards
          .where(
            (hazard) =>
                hazard.accidentType.name == accidentType.name &&
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

  void search(String query) {
    List<HazardModel> newDisplayedHazards = [];
    if (state.value?.selectedAccidentType == null) {
      newDisplayedHazards = state.value!.hazards
          .where((hazard) =>
              hazard.cityName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      newDisplayedHazards = state.value!.hazards
          .where(
            (hazard) =>
                hazard.accidentType.name ==
                    state.value!.selectedAccidentType!.name &&
                hazard.cityName.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();
    }
    state = AsyncData(
      state.value!.copyWith(
        query: query,
        displayedHazards: newDisplayedHazards,
      ),
    );
  }
}
