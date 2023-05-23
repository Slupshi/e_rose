import 'package:e_rose/models/accident.dart';
import 'package:e_rose/models/declaration.dart';
import 'package:e_rose/models/repositories/accident_repository.dart';
import 'package:e_rose/models/repositories/declaration_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accidents_map_controller.g.dart';
part 'accidents_map_controller.freezed.dart';

@freezed
class AccidentMapState with _$AccidentMapState {
  const factory AccidentMapState({
    required List<Accident> accidentsTypes,
    Accident? selectedAccidentType,
    String? query,
    required List<DeclarationModel> hazards,
    required List<DeclarationModel> displayedHazards,
  }) = _AccidentMapState;
}

@riverpod
class AccidentMapController extends _$AccidentMapController {
  @override
  FutureOr<AccidentMapState> build() async {
    final List<DeclarationModel> hazards =
        await ref.read(declarationRepositoryProvider).getDeclarations();
    final List<Accident> accidents =
        await ref.read(accidentRepositoryProvider).getAccidents();
    return AccidentMapState(
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
    List<DeclarationModel> newDisplayedHazards = [];
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
    List<DeclarationModel> newDisplayedHazards = [];
    if (state.value?.selectedAccidentType == null) {
      newDisplayedHazards = [...state.value!.hazards];
    } else {
      newDisplayedHazards = state.value!.hazards
          .where((hazard) =>
              hazard.accident.name == state.value!.selectedAccidentType!.name)
          .toList();
    }
    state = AsyncData(
      state.value!.copyWith(
        displayedHazards: newDisplayedHazards,
        query: null,
      ),
    );
  }

  void selectAccident(Accident accidentType) {
    List<DeclarationModel> newDisplayedHazards = [];
    if (state.value?.query == null) {
      newDisplayedHazards = state.value!.hazards
          .where((hazard) => hazard.accident.name == accidentType.name)
          .toList();
    } else {
      newDisplayedHazards = state.value!.hazards
          .where(
            (hazard) =>
                hazard.accident.name == accidentType.name &&
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
    state = AsyncData(
      state.value!.copyWith(
        query: query,
        displayedHazards: state.value!.hazards
            .where((hazard) =>
                hazard.cityName.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      ),
    );
  }
}
