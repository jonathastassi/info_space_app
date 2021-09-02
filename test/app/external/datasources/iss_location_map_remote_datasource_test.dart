import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/data/datasources/i_iss_location_map_remote_datasource.dart';
import 'package:info_space_app/app/external/datasources/iss_location_map_remote_datasource.dart';
import 'package:info_space_app/app/external/http/http_client.dart';
import 'package:info_space_app/core/errors/expections.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('External - datasources - PeopleInSpaceRemoteDatasource', () {
    late HttpClient httpClient;
    late IIssLocationMapRemoteDatasource issLocationMapRemoteDatasource;

    setUp(() {
      httpClient = MockHttpClient();
      issLocationMapRemoteDatasource = IssLocationMapRemoteDatasource(
        httpClient: httpClient,
      );
    });

    test('Should return iss location from API', () async {
      final peoplesInSpaceJson = json.decode(fixture('iss_location.json'));
      when(() => httpClient.get(any())).thenAnswer(
        (_) async => Response(
            requestOptions:
                RequestOptions(path: 'http://api.open-notify.org/iss-now.json'),
            data: peoplesInSpaceJson),
      );

      final result = await issLocationMapRemoteDatasource.getIssLocation();

      verify(() => httpClient.get(any())).called(1);
      expect(result.timestamp, equals('1630589659'));
      expect(result.position.latitude, equals(-48.1380));
      expect(result.position.longitude, equals(72.4900));
    });

    test(
        'Should return ServerException when API doesn\'t return message success',
        () async {
      final peoplesInSpaceJson =
          json.decode(fixture('iss_location_not_success.json'));
      when(() => httpClient.get(any())).thenAnswer(
        (_) async => Response(
            requestOptions:
                RequestOptions(path: 'http://api.open-notify.org/iss-now.json'),
            data: peoplesInSpaceJson),
      );

      expect(() => issLocationMapRemoteDatasource.getIssLocation(),
          throwsA(isA<ServerException>()));
    });
  });
}
