import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/domain/repositories/i_people_in_space_repository.dart';
import 'package:info_space_app/app/domain/usecases/get_peoples_in_space_usecase.dart';
import 'package:info_space_app/core/errors/failure.dart';
import 'package:info_space_app/core/usecases/usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockPeoplesInSpaceRepository extends Mock
    implements IPeoplesInSpaceRepository {}

final List<PeopleInSpaceEntity> mockPeoples = [
  PeopleInSpaceEntity(name: "name", craft: "craft"),
  PeopleInSpaceEntity(name: "name 2", craft: "craft 2"),
  PeopleInSpaceEntity(name: "name 3", craft: "craft 3"),
];

void main() {
  group('Domain - usecases - GetPersonsInSpaceUsecase', () {
    late IPeoplesInSpaceRepository peoplesInSpaceRepository;
    late GetPeoplesInSpaceUsecase usecase;

    setUp(() {
      peoplesInSpaceRepository = MockPeoplesInSpaceRepository();
      usecase = GetPeoplesInSpaceUsecase(
        peoplesInSpaceRepository: peoplesInSpaceRepository,
      );
    });

    test('Should get a list of persons in space from the repository', () async {
      when(() => peoplesInSpaceRepository.getPeoplesInSpace()).thenAnswer(
          (_) async => Right<Failure, List<PeopleInSpaceEntity>>(mockPeoples));

      final result = await usecase(NoParams());

      expect(result, Right<Failure, List<PeopleInSpaceEntity>>(mockPeoples));
      verify(() => peoplesInSpaceRepository.getPeoplesInSpace()).called(1);
    });
  });
}
