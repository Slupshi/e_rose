import 'package:e_rose/models/hero.dart';
import 'package:e_rose/services/api/dto/heroes_response.dart';
import 'package:e_rose/services/sources/hero_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hero_repository.g.dart';

@riverpod
HeroRepository heroRepository(HeroRepositoryRef ref) => HeroRepository(
      heroSource: ref.watch(heroSourceProvider),
    );

class HeroRepository {
  final HeroSource heroSource;
  HeroRepository({
    required this.heroSource,
  });

  Future<List<HeroModel>> getHeroes() async {
    final response = await heroSource.getHeroes();
    final heroesResponse = HeroesResponse.fromJson(response);
    final heroes = heroesResponse.items;
    return heroes;
  }
}
