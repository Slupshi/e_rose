import 'package:e_rose/models/hero.dart';
import 'package:e_rose/models/repositories/hero_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hero_controller.g.dart';
part 'hero_controller.freezed.dart';

@freezed
class HeroState with _$HeroState {
  const factory HeroState({
    required List<HeroModel> heroes,
    required HeroModel? selectedhero,
  }) = _HeroState;
}

@riverpod
class HeroController extends _$HeroController {
  @override
  FutureOr<HeroState> build() async {
    final heroes = await ref.read(heroRepositoryProvider).getHeroes();
    return HeroState(
      heroes: heroes,
      selectedhero: heroes.isNotEmpty ? heroes.first : null,
    );
  }

  void select(HeroModel hero) {
    state = AsyncData(
      state.value!.copyWith(selectedhero: hero),
    );
  }
}
