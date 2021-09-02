import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/data/datasources/i_iss_location_map_remote_datasource.dart';
import 'package:info_space_app/app/data/models/iss_location_map_model.dart';
import 'package:info_space_app/app/data/models/position_model.dart';
import 'package:info_space_app/app/data/repositories/iss_location_map_repository.dart';
import 'package:info_space_app/app/domain/repositories/i_iss_location_map_repository.dart';
import 'package:info_space_app/core/errors/expections.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';
import 'package:mocktail/mocktail.dart';

class MockIssLocationMapRemoteDatasource extends Mock
    implements IIssLocationMapRemoteDatasource {}

class MockNetworkStatus extends Mock implements INetworkStatus {}

void main() {
  group('Data - Repositories - IssLocationMapRepository', () {
    late IIssLocationMapRemoteDatasource issLocationMapRemoteDatasource;
    late IIssLocationMapRepository issLocationMapRepository;
    late INetworkStatus networkStatus;

    setUp(() {
      networkStatus = MockNetworkStatus();
      issLocationMapRemoteDatasource = MockIssLocationMapRemoteDatasource();
      issLocationMapRepository = IssLocationMapRepository(
          issLocationMapRemoteDatasource: issLocationMapRemoteDatasource,
          networkStatus: networkStatus);
    });

    test(
        'When has connection, should return iss location from remote datasource',
        () async {
      final issLocationMock = IssLocationMapModel(
        timestamp: '123456',
        position: PositionModel(
          latitude: '123',
          longitude: '456',
        ),
      );

      when(() => networkStatus.isConnected).thenAnswer((_) async => true);
      when(() => issLocationMapRemoteDatasource.getIssLocation())
          .thenAnswer((_) async => issLocationMock);

      final result = await issLocationMapRepository.getIssLocation();

      expect(result, Right(issLocationMock));
      verify(() => issLocationMapRemoteDatasource.getIssLocation()).called(1);
    });

    test('When does not have connection, should return NoConnectionFailure',
        () async {
      when(() => networkStatus.isConnected).thenAnswer((_) async => false);

      final result = await issLocationMapRepository.getIssLocation();

      expect(result, Left(NoConnectionFailure()));
    });

    test('Should return ServerFailure when handle ServerException', () async {
      when(() => networkStatus.isConnected).thenAnswer((_) async => true);
      when(() => issLocationMapRemoteDatasource.getIssLocation())
          .thenThrow(ServerException());

      final result = await issLocationMapRepository.getIssLocation();

      expect(result, Left(ServerFailure()));
    });
  });
}
