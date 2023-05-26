import 'package:e_rose/models/hazard_model.dart';
import 'package:e_rose/services/sources/hazard_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hazard_repository.g.dart';

@riverpod
HazardRepository hazardRepository(HazardRepositoryRef ref) => HazardRepository(
      hazardSource: ref.watch(hazardSourceProvider),
    );

class HazardRepository {
  final HazardSource hazardSource;
  HazardRepository({
    required this.hazardSource,
  });

  Future<List<HazardModel>> getHazards() async {
    final response = await hazardSource.getHazards();
    final declarations =
        (response as List).map((e) => HazardModel.fromJson(e)).toList();
    return declarations;
  }

  Future<HazardModel> postHazard(HazardModel model) async {
    final response = await hazardSource.postHazard(model);
    return HazardModel.fromJson(response);
  }
}
