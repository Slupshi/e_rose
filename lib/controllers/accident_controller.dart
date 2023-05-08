import 'package:e_rose/models/accident.dart';
import 'package:e_rose/models/repositories/accident_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accident_controller.g.dart';
part 'accident_controller.freezed.dart';

@freezed
class AccidentState with _$AccidentState {
  const factory AccidentState({
    required List<Accident> accidents,
    required Accident selectedAccident,
  }) = _AccidentState;
}

@riverpod
class AccidentController extends _$AccidentController {
  @override
  FutureOr<AccidentState> build() async {
    final accidents = await ref.read(accidentRepositoryProvider).getAccidents();
    accidents.sort((a, b) => a.id.compareTo(b.id));
    return AccidentState(
      accidents: accidents,
      selectedAccident: accidents.first,
    );
  }

  void select(Accident accident) {
    state = AsyncData(
      state.value!.copyWith(selectedAccident: accident),
    );
  }
}
