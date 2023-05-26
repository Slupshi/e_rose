import 'package:dio/dio.dart';
import 'package:e_rose/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service.g.dart';

@riverpod
ApiService apiService(ApiServiceRef ref) {
  return ApiService();
}

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio();
  }

  Future httpGet(String url, {int? id}) async {
    final response = await _dio.get(
      "${Env.baseApiUrl}/$url${id != null ? "/$id" : ""}",
    );
    return response.data;
  }

  Future httpPost(String url, Object model) async {
    final response = await _dio.post(
      "${Env.baseApiUrl}/$url",
      data: model,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );
    return response.data;
  }

  Future httpPut(String url, Object model, int id) async {
    final response = await _dio.put(
      "${Env.baseApiUrl}/$url/$id",
      data: model,
    );
    return response.data;
  }

  Future httpDelete(String url, int id) async {
    final response = await _dio.delete("${Env.baseApiUrl}/$url/$id");
    return response.data;
  }
}
