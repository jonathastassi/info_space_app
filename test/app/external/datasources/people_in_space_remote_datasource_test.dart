import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/external/datasources/people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/external/http/http_client.dart';
import 'package:info_space_app/core/errors/expections.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('External - datasources - PeopleInSpaceRemoteDatasource', () {
    late HttpClient httpClient;
    late PeopleInSpaceRemoteDatasource peopleInSpaceRemoteDatasource;

    setUp(() {
      httpClient = MockHttpClient();
      peopleInSpaceRemoteDatasource = PeopleInSpaceRemoteDatasource(
        httpClient: httpClient,
      );
    });

    test('Should return a list of peoples from API', () async {
      final peoplesInSpaceJson = fixture('peoples_in_space.json');
      when(() => httpClient.get(any())).thenAnswer(
        (_) async => Response(
            requestOptions:
                RequestOptions(path: 'http://api.open-notify.org/astros.json'),
            data: peoplesInSpaceJson),
      );

      final result = await peopleInSpaceRemoteDatasource.getPeoplesInSpace();

      verify(() => httpClient.get(any())).called(1);
      expect(result.length, equals(3));
    });

    test('Should return empty list', () async {
      final peoplesInSpaceJson = fixture('peoples_in_space_empty.json');
      when(() => httpClient.get(any())).thenAnswer(
        (_) async => Response(
            requestOptions:
                RequestOptions(path: 'http://api.open-notify.org/astros.json'),
            data: peoplesInSpaceJson),
      );

      final result = await peopleInSpaceRemoteDatasource.getPeoplesInSpace();

      verify(() => httpClient.get(any())).called(1);
      expect(result.length, equals(0));
    });

    test(
        'Should return ServerException when API doesn\'t return message success',
        () async {
      final peoplesInSpaceJson = fixture('peoples_in_space_not_success.json');
      when(() => httpClient.get(any())).thenAnswer(
        (_) async => Response(
            requestOptions:
                RequestOptions(path: 'http://api.open-notify.org/astros.json'),
            data: peoplesInSpaceJson),
      );

      expect(() => peopleInSpaceRemoteDatasource.getPeoplesInSpace(),
          throwsA(isA<ServerException>()));
    });

    test('Should return ServerException on Exception', () async {
      when(() => httpClient.get(any())).thenThrow(Exception());

      expect(() => peopleInSpaceRemoteDatasource.getPeoplesInSpace(),
          throwsA(isA<ServerException>()));
    });
  });
}
