import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/data/models/people_in_space_model.dart';
import 'package:info_space_app/app/internal/datasources/people_in_space_local_datasource.dart';
import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';
import 'package:info_space_app/app/internal/local_storage/local_storage.dart';
import 'package:info_space_app/core/errors/expections.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  group('Internal - datasources - PeopleInSpaceLocalDatasource', () {
    late ILocalStorage localStorage;
    late PeopleInSpaceLocalDatasource peopleInSpaceLocalDatasource;

    final List<PeopleInSpaceModel> mockPeoples = [
      PeopleInSpaceModel(name: "name", craft: "craft"),
      PeopleInSpaceModel(name: "name 2", craft: "craft 2"),
      PeopleInSpaceModel(name: "name 3", craft: "craft 3"),
    ];

    final String mockPeoplesJson =
        '[{"name":"name","craft":"craft"},{"name":"name 2","craft":"craft 2"},{"name":"name 3","craft":"craft 3"}]';

    setUp(() {
      localStorage = MockLocalStorage();
      peopleInSpaceLocalDatasource = PeopleInSpaceLocalDatasource(
        localStorage: localStorage,
      );
    });

    test(
        'Should save peoples list in the localStorage when cacheLastPeoplesInSpace is called',
        () async {
      when(() =>
              localStorage.setString(CACHED_PEOPLES_IN_SPACE, mockPeoplesJson))
          .thenAnswer((_) async => true);

      await peopleInSpaceLocalDatasource.cacheLastPeoplesInSpace(mockPeoples);

      verify(() =>
              localStorage.setString(CACHED_PEOPLES_IN_SPACE, mockPeoplesJson))
          .called(1);
    });

    test('Should throw CacheException when setString return false', () async {
      when(() => localStorage.setString(CACHED_PEOPLES_IN_SPACE, any()))
          .thenAnswer((_) async => false);

      expect(
          () =>
              peopleInSpaceLocalDatasource.cacheLastPeoplesInSpace(mockPeoples),
          throwsA(isA<CacheException>()));
    });

    test(
        'Should return a list of peoples stored in the localStorage when getLastPeoplesInSpace is called',
        () async {
      when(() => localStorage.getString(CACHED_PEOPLES_IN_SPACE))
          .thenReturn(mockPeoplesJson);

      final result = await peopleInSpaceLocalDatasource.getLastPeoplesInSpace();

      verify(() => localStorage.getString(CACHED_PEOPLES_IN_SPACE)).called(1);
      expect(result.length, equals(3));
    });

    test('Should return an empty list cache is empty', () async {
      when(() => localStorage.getString(CACHED_PEOPLES_IN_SPACE))
          .thenThrow(Exception());

      expect(() => peopleInSpaceLocalDatasource.getLastPeoplesInSpace(),
          throwsA(isA<CacheException>()));
    });
  });
}
