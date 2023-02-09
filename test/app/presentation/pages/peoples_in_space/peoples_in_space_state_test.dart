import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/feature/peoples_in_space/presenter/controller/peoples_in_space_state.dart';
import 'package:info_space_app/core/errors/failures.dart';

void main() {
  group('Presentation - pages - PeopleInSpaceState', () {
    test('Should be created with default values', () {
      PeoplesInSpaceState state = PeoplesInSpaceState();

      expect(state.isLoading, isFalse);
      expect(state.failure, isNull);
      expect(state.peopleInSpaceList, []);
    });

    test('isLoading should true on loading factory', () {
      PeoplesInSpaceState state = PeoplesInSpaceState.loading();

      expect(state.isLoading, isTrue);
      expect(state.failure, isNull);
      expect(state.peopleInSpaceList, []);
    });

    test('Should receive a list on showList factory', () {
      final list = [
        PeopleInSpaceEntity(name: 'some name', craft: 'some craft'),
        PeopleInSpaceEntity(name: 'some name 2', craft: 'some craft 2'),
        PeopleInSpaceEntity(name: 'some name 3', craft: 'some craft 3'),
      ];

      PeoplesInSpaceState state = PeoplesInSpaceState.showList(list);

      expect(state.isLoading, isFalse);
      expect(state.failure, isNull);
      expect(state.peopleInSpaceList.length, list.length);
    });

    test('Should receive a failure on setFailure factory', () {
      PeoplesInSpaceState state =
          PeoplesInSpaceState.setFailure(ServerFailure());

      expect(state.isLoading, isFalse);
      expect(state.failure, ServerFailure());
      expect(state.peopleInSpaceList.length, 0);
    });
  });
}
