import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:info_space_app/app/domain/repositories/i_iss_location_map_repository.dart';
import 'package:info_space_app/app/domain/usecases/get_iss_location_map_usecase.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/usecases/usecase.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';

class MockIssLocationMapRepository extends Mock
    implements IIssLocationMapRepository {}

void main() {
  group('Domain - usecases - GetIssLocationMapUsecase', () {
    late GetIssLocationMapUsecase usecase;
    late IIssLocationMapRepository issLocationMapRepositoryMock;

    setUp(() {
      issLocationMapRepositoryMock = MockIssLocationMapRepository();
      usecase = GetIssLocationMapUsecase(
          issLocationMapRepository: issLocationMapRepositoryMock);
    });

    test('Should get last position of iss from repository', () async {
      final mockIssLocation = IssLocationMapEntity(
        position: LatLng(50, 70),
        timestamp: '1234567',
      );

      when(() => issLocationMapRepositoryMock.getIssLocation()).thenAnswer(
        (_) async => Right<Failure, IssLocationMapEntity>(
          mockIssLocation,
        ),
      );

      final result = await usecase.call(NoParams());

      expect(result, Right<Failure, IssLocationMapEntity>(mockIssLocation));
      verify(() => issLocationMapRepositoryMock.getIssLocation()).called(1);
      verifyNoMoreInteractions(issLocationMapRepositoryMock);
    });
  });
}
