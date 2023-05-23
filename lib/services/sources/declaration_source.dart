import 'package:e_rose/models/declaration.dart';
import 'package:e_rose/services/api/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'declaration_source.g.dart';

@riverpod
DeclarationSource declarationSource(DeclarationSourceRef ref) =>
    DeclarationSource(
      apiService: ref.watch(apiServiceProvider),
    );

class DeclarationSource {
  final String url = "Declarations";
  final ApiService apiService;

  DeclarationSource({
    required this.apiService,
  });

  Future getDeclarations() async => await apiService.httpGet(url);

  Future postDeclaration(DeclarationModel model) async =>
      apiService.httpPost(url, model);
}
