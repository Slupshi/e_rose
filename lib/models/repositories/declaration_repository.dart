import 'package:e_rose/models/declaration.dart';
import 'package:e_rose/services/sources/declaration_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'declaration_repository.g.dart';

@riverpod
DeclarationRepository declarationRepository(DeclarationRepositoryRef ref) =>
    DeclarationRepository(
      declarationSource: ref.watch(declarationSourceProvider),
    );

class DeclarationRepository {
  final DeclarationSource declarationSource;
  DeclarationRepository({
    required this.declarationSource,
  });

  Future<List<DeclarationModel>> getDeclarations() async {
    final response = await declarationSource.getDeclarations();
    final declarations =
        (response as List).map((e) => DeclarationModel.fromJson(e)).toList();
    return declarations;
  }

  Future<DeclarationModel> postDeclaration(DeclarationModel model) async {
    final response = await declarationSource.postDeclaration(model);
    return DeclarationModel.fromJson(response);
  }
}
