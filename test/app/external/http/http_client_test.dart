import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/external/http/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('External - http - HttpClient', () {
    late HttpClient httpClient;
    late Dio dio;

    setUp(() {
      dio = MockDio();
      httpClient = HttpClient(
        dio: dio,
      );
    });

    test('When executed get(any) should call dio.get', () async {
      const URL = 'http://api.open-notify.org/astros.json';
      when(() => dio.get(URL)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: URL), data: 'some_data'));

      final result = await httpClient.get(URL);

      expect(result.data, 'some_data');
      verify(() => dio.get(URL)).called(1);
    });
  });
}
