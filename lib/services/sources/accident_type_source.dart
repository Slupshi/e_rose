import 'package:e_rose/services/api/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accident_type_source.g.dart';

@riverpod
AccidentTypeSource accidentTypeSource(AccidentTypeSourceRef ref) =>
    AccidentTypeSource(
      apiService: ref.watch(apiServiceProvider),
    );

class AccidentTypeSource {
  final String url = "Accidents";
  final ApiService apiService;

  AccidentTypeSource({
    required this.apiService,
  });

  Future getAccidentTypes() async => await apiService.httpGet(url);
}
