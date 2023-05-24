import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/repositories/accident_type_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accident_type_list_controller.g.dart';
part 'accident_type_list_controller.freezed.dart';

@freezed
class AccidentTypeState with _$AccidentTypeState {
  const factory AccidentTypeState({
    required List<AccidentTypeModel> accidentTypes,
    required AccidentTypeModel selectedAccidentType,
  }) = _AccidentTypeState;
}

@riverpod
class AccidentTypeListController extends _$AccidentTypeListController {
  @override
  FutureOr<AccidentTypeState> build() async {
    final accidentTypes =
        await ref.read(accidentTypeRepositoryProvider).getAccidents();
    accidentTypes.sort((a, b) => a.id.compareTo(b.id));
    return AccidentTypeState(
      accidentTypes: accidentTypes,
      selectedAccidentType: accidentTypes.first,
    );
  }

  void select(AccidentTypeModel accidentType) {
    state = AsyncData(
      state.value!.copyWith(selectedAccidentType: accidentType),
    );
  }
}
