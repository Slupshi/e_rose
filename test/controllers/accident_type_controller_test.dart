import 'package:e_rose/controllers/accident_type_list_controller.dart';
import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/repositories/accident_type_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'accident_type_controller_test.mocks.dart';

@GenerateMocks([
  AccidentTypeRepository,
])
void main() {
  group("AccidentTypeController", () {
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

    final AccidentTypeState defaultState = AccidentTypeState(
      accidentTypes: defaultAccidentType,
      selectedAccidentType: defaultAccidentType.first,
    );
    test("Build returns AccidentTypeState", () async {
      // setup
      final data = initializeAndSetup();
      when(data.accidentTypeRepository.getAccidentTypes())
          .thenAnswer((_) async => defaultAccidentType);
      final AccidentTypeListController accidentTypeController =
          data.container.read(accidentTypeListControllerProvider.notifier);
      // run
      final result = await accidentTypeController.future;
      // verify
      expect(result, defaultState);
    });
  });
}

AccidentTypeControllerContainerData initializeAndSetup() {
  final MockAccidentTypeRepository accidentTypeRepository =
      MockAccidentTypeRepository();
  final ProviderContainer container = ProviderContainer(overrides: [
    accidentTypeRepositoryProvider.overrideWithValue(accidentTypeRepository),
  ]);
  return AccidentTypeControllerContainerData(
    container: container,
    accidentTypeRepository: accidentTypeRepository,
  );
}

class AccidentTypeControllerContainerData {
  final ProviderContainer container;
  final MockAccidentTypeRepository accidentTypeRepository;

  AccidentTypeControllerContainerData({
    required this.container,
    required this.accidentTypeRepository,
  });
}
