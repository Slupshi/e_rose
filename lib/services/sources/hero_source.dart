import 'package:e_rose/services/api/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hero_source.g.dart';

@riverpod
HeroSource heroSource(HeroSourceRef ref) => HeroSource(
      apiService: ref.watch(apiServiceProvider),
    );

class HeroSource {
  final String url = "Heroes";
  final ApiService apiService;

  HeroSource({
    required this.apiService,
  });

  Future getHeroes() async => await apiService.httpGet(url);
}
