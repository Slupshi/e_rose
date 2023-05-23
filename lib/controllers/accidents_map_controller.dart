import 'package:e_rose/models/accident.dart';
import 'package:e_rose/models/declaration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accidents_map_controller.g.dart';
part 'accidents_map_controller.freezed.dart';

@freezed
class AccidentMapState with _$AccidentMapState {
  const factory AccidentMapState({
    required List<Accident> accidentsTypes,
    required List<DeclarationModel> hazards,
    required List<DeclarationModel> displayedHazards,
  }) = _AccidentMapState;
}

@riverpod
class AccidentMapController extends _$AccidentMapController {
  @override
  FutureOr<AccidentMapState> build() async {
    return const AccidentMapState(
      accidentsTypes: [],
      hazards: [],
      displayedHazards: [],
    );
  }
}
