import 'package:e_rose/services/api/dto/auth/login_model.dart';
import 'package:e_rose/models/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  void build() {
    //
  }

  Future<bool> login(LoginModel model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final authRepo = ref.read(authRepositoryProvider);
      final response = await authRepo.login(model);
      await prefs.setString("token", response.token);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<void> disconnect() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}
