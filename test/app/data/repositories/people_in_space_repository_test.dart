import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_local_datasource.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/data/models/people_in_space_model.dart';
import 'package:info_space_app/app/data/repositories/people_in_space_repository.dart';
import 'package:info_space_app/app/domain/repositories/i_people_in_space_repository.dart';
import 'package:info_space_app/core/errors/expections.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';
import 'package:mocktail/mocktail.dart';

class MockPeopleInSpaceRemoteDatasource extends Mock
    implements IPeopleInSpaceRemoteDatasource {}

class MockPeopleInSpaceLocalDatasource extends Mock
    implements IPeopleInSpaceLocalDatasource {}

class MockNetworkStatus extends Mock implements INetworkStatus {}

void main() {
  group('Data - repositories - PeopleInSpaceRepository', () {
    late IPeopleInSpaceRemoteDatasource peopleInSpaceRemoteDatasource;
    late IPeopleInSpaceLocalDatasource peopleInSpaceLocalDatasource;
    late INetworkStatus networkStatus;
    late IPeopleInSpaceRepository peoplesInSpaceRepository;

    final List<PeopleInSpaceModel> mockPeoplesModels = [
      PeopleInSpaceModel(name: "name", craft: "craft"),
      PeopleInSpaceModel(name: "name 2", craft: "craft 2"),
      PeopleInSpaceModel(name: "name 3", craft: "craft 3"),
    ];

    setUp(() {
      peopleInSpaceRemoteDatasource = MockPeopleInSpaceRemoteDatasource();
      peopleInSpaceLocalDatasource = MockPeopleInSpaceLocalDatasource();
      networkStatus = MockNetworkStatus();
      peoplesInSpaceRepository = PeopleInSpaceRepository(
        networkStatus: networkStatus,
        peopleInSpaceLocalDatasource: peopleInSpaceLocalDatasource,
        peopleInSpaceRemoteDatasource: peopleInSpaceRemoteDatasource,
      );
    });

    group('When network status is connected', () {
      setUp(() {
        when(() => networkStatus.isConnected).thenAnswer((_) async => true);
      });

      test(
          'Should return a list of peoples in space from remote datasource and save the result at local',
          () async {
        when(() => peopleInSpaceRemoteDatasource.getPeoplesInSpace())
            .thenAnswer((_) async => mockPeoplesModels);
        when(() => peopleInSpaceLocalDatasource.cacheLastPeoplesInSpace(any()))
            .thenAnswer((_) async => Void);

        final result = await peoplesInSpaceRepository.getPeoplesInSpace();

        expect(result, Right(mockPeoplesModels));
        verify(() => peopleInSpaceRemoteDatasource.getPeoplesInSpace())
            .called(1);
        verifyNever(() => peopleInSpaceLocalDatasource.getLastPeoplesInSpace());
        verify(
            () => peopleInSpaceLocalDatasource.cacheLastPeoplesInSpace(any()));
      });

      test('Should return ServerException when ocurred an error', () async {
        when(() => peopleInSpaceRemoteDatasource.getPeoplesInSpace())
            .thenThrow(ServerException());

        final result = await peoplesInSpaceRepository.getPeoplesInSpace();

        expect(result, Left(ServerFailure()));
      });
    });

    group('When network status is offline', () {
      setUp(() {
        when(() => networkStatus.isConnected).thenAnswer((_) async => false);
      });

      test(
          'Should return a list of peoples in space from local datasource and doesn\'t have to save ',
          () async {
        when(() => peopleInSpaceLocalDatasource.getLastPeoplesInSpace())
            .thenAnswer((_) async => mockPeoplesModels);
        when(() => peopleInSpaceLocalDatasource.cacheLastPeoplesInSpace(any()))
            .thenAnswer((_) async => Void);

        final result = await peoplesInSpaceRepository.getPeoplesInSpace();

        expect(result, Right(mockPeoplesModels));
        verifyNever(() => peopleInSpaceRemoteDatasource.getPeoplesInSpace());
        verify(() => peopleInSpaceLocalDatasource.getLastPeoplesInSpace())
            .called(1);
        verifyNever(
            () => peopleInSpaceLocalDatasource.cacheLastPeoplesInSpace(any()));
      });

      test('Should return ServerException when ocurred an error', () async {
        when(() => peopleInSpaceLocalDatasource.getLastPeoplesInSpace())
            .thenThrow(CacheException());

        final result = await peoplesInSpaceRepository.getPeoplesInSpace();

        expect(result, Left(CacheFailure()));
      });
    });
  });
}
