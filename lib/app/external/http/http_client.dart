import 'package:dio/dio.dart';
import 'package:info_space_app/app/external/http/i_http_client.dart';

class HttpClient implements IHttpClient {
  final Dio dio;

  HttpClient({required this.dio});

  @override
  Future get(String url) async {
    try {
      return await dio.get(url);
    } catch (error) {
      throw error;
    }
  }
}
