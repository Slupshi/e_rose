import 'package:e_rose/services/api/dto/auth/auth_model.dart';
import 'package:e_rose/services/api/dto/auth/login_model.dart';
import 'package:e_rose/services/api/dto/auth/register_model.dart';
import 'package:e_rose/services/sources/auth_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository(
      authSource: ref.watch(authSourceProvider),
    );

class AuthRepository {
  final AuthSource authSource;
  AuthRepository({
    required this.authSource,
  });

  Future<AuthModel> login(LoginModel model) async {
    final response = await authSource.login(model);
    return AuthModel.fromJson(response);
  }

  Future<AuthModel> register(RegisterModel model) async {
    final response = await authSource.register(model);
    return AuthModel.fromJson(response);
  }
}
