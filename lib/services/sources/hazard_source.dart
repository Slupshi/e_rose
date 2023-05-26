import 'package:e_rose/models/hazard_model.dart';
import 'package:e_rose/services/api/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hazard_source.g.dart';

@riverpod
HazardSource hazardSource(HazardSourceRef ref) => HazardSource(
      apiService: ref.watch(apiServiceProvider),
    );

class HazardSource {
  final String url = "Hazards";
  final ApiService apiService;

  HazardSource({
    required this.apiService,
  });

  Future getHazards() async => await apiService.httpGet(url);

  Future postHazard(HazardModel model) async => apiService.httpPost(url, model);
}
