import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'API_URL')
  static const baseApiUrl = _Env.baseApiUrl;
}
