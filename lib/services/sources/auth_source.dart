import 'package:e_rose/services/api/dto/auth/login_model.dart';
import 'package:e_rose/services/api/dto/auth/register_model.dart';
import 'package:e_rose/services/api/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_source.g.dart';

@riverpod
AuthSource authSource(AuthSourceRef ref) => AuthSource(
      apiService: ref.watch(apiServiceProvider),
    );

class AuthSource {
  final String url = "Auth";
  final ApiService apiService;

  AuthSource({
    required this.apiService,
  });

  Future login(LoginModel model) async => await apiService.httpPost(
        "$url/login",
        model,
      );

  Future register(RegisterModel model) async => await apiService.httpPost(
        "$url/register",
        model,
      );
}
