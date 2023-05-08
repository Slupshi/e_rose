import 'package:e_rose/services/api/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accident_source.g.dart';

@riverpod
AccidentSource accidentSource(AccidentSourceRef ref) => AccidentSource(
      apiService: ref.watch(apiServiceProvider),
    );

class AccidentSource {
  final String url = "Accidents";
  final ApiService apiService;

  AccidentSource({
    required this.apiService,
  });

  Future getAccidents() async => await apiService.httpGet(url);
}
