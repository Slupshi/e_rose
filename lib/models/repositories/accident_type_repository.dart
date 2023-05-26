import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/services/sources/accident_type_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accident_type_repository.g.dart';

@riverpod
AccidentTypeRepository accidentTypeRepository(AccidentTypeRepositoryRef ref) =>
    AccidentTypeRepository(
      accidentTypeSource: ref.watch(accidentTypeSourceProvider),
    );

class AccidentTypeRepository {
  final AccidentTypeSource accidentTypeSource;
  AccidentTypeRepository({
    required this.accidentTypeSource,
  });

  Future<List<AccidentTypeModel>> getAccidentTypes() async {
    final response = await accidentTypeSource.getAccidentTypes();
    final accidentTypes =
        (response as List).map((e) => AccidentTypeModel.fromJson(e)).toList();
    return accidentTypes;
  }
}
