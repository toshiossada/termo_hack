import 'http_response.dart';

abstract class IHttpClientAdapter {
  Future<HttpResponse> get(
    String path, {
    Map<String, String> queryParameters,
    Map<String, String> headers,
    bool cached = false,
  });

  Future<HttpResponse> post(
    String path, {
    dynamic data,
    Map<String, String> queryParameters,
    Map<String, String> headers,
  });

  Future<HttpResponse> put(
    String path, {
    data,
    Map<String, String> queryParameters,
    Map<String, String> headers,
  });

  Future<HttpResponse> delete(
    String path, {
    Map<String, String> queryParameters,
    Map<String, String> headers,
  });
}
