import 'package:e_rose/models/accident.dart';
import 'package:e_rose/services/sources/accident_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accident_repository.g.dart';

@riverpod
AccidentRepository accidentRepository(AccidentRepositoryRef ref) =>
    AccidentRepository(
      accidentSource: ref.watch(accidentSourceProvider),
    );

class AccidentRepository {
  final AccidentSource accidentSource;
  AccidentRepository({
    required this.accidentSource,
  });

  Future<List<Accident>> getAccidents() async {
    final response = await accidentSource.getAccidents();
    final accidents =
        (response as List).map((e) => Accident.fromJson(e)).toList();
    return accidents;
  }
}
