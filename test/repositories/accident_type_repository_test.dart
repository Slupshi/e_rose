import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/repositories/accident_type_repository.dart';
import 'package:e_rose/services/sources/accident_type_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'accident_type_repository_test.mocks.dart';

@GenerateMocks([
  AccidentTypeSource,
])
void main() {
  group("AccidentRepository", () {
    List<Map<String, Object>> defaultAccidentTypeJson = [
      {
        "id": 1,
        "name": "Incendie",
        "description": "Ca brule",
        "iconCode": "1",
        "iconFontFamily": "1",
        "iconFontPackage": "1",
      },
      {
        "id": 1,
        "name": "Incendie",
        "description": "Ca brule",
        "iconCode": "1",
        "iconFontFamily": "1",
        "iconFontPackage": "1",
      },
      {
        "id": 1,
        "name": "Incendie",
        "description": "Ca brule",
        "iconCode": "1",
        "iconFontFamily": "1",
        "iconFontPackage": "1",
      },
    ];
    List<AccidentTypeModel> defaultAccidentType = [
      const AccidentTypeModel(
        id: 1,
        name: "Incendie",
        description: "Ca brule",
        iconCode: "1",
        iconFontFamily: "1",
        iconFontPackage: "1",
      ),
      const AccidentTypeModel(
        id: 1,
        name: "Incendie",
        description: "Ca brule",
        iconCode: "1",
        iconFontFamily: "1",
        iconFontPackage: "1",
      ),
      const AccidentTypeModel(
        id: 1,
        name: "Incendie",
        description: "Ca brule",
        iconCode: "1",
        iconFontFamily: "1",
        iconFontPackage: "1",
      ),
    ];
    test("getAccidentTypes returns List<AccidentTypeModel>", () async {
      // setup
      final data = initializeAndSetup();
      when(data.accidentTypeSource.getAccidentTypes())
          .thenAnswer((_) async => defaultAccidentTypeJson);
      final AccidentTypeRepository accidentTypeRepository =
          data.container.read(accidentTypeRepositoryProvider);
      // run
      final result = await accidentTypeRepository.getAccidentTypes();
      // verify
      expect(result, defaultAccidentType);
    });
  });
}

AccidentTypeRepositoryContainerData initializeAndSetup() {
  final MockAccidentTypeSource accidentTypeSource = MockAccidentTypeSource();
  final ProviderContainer container = ProviderContainer(overrides: [
    accidentTypeSourceProvider.overrideWithValue(accidentTypeSource),
  ]);
  return AccidentTypeRepositoryContainerData(
    container: container,
    accidentTypeSource: accidentTypeSource,
  );
}

class AccidentTypeRepositoryContainerData {
  final ProviderContainer container;
  final MockAccidentTypeSource accidentTypeSource;

  AccidentTypeRepositoryContainerData({
    required this.container,
    required this.accidentTypeSource,
  });
}
