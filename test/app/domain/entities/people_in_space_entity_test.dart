import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';

void main() {
  group('Domain - entities - PeopleInSpaceEntity', () {
    test('Should be created', () {
      PeopleInSpaceEntity entity = PeopleInSpaceEntity(
        name: 'Some name',
        craft: 'Some creaft',
      );

      expect(entity.name, 'Some name');
      expect(entity.craft, 'Some creaft');
    });

    test('When have entities with same attributes, should be equal', () {
      PeopleInSpaceEntity entity = PeopleInSpaceEntity(
        name: 'Some name',
        craft: 'Some creaft',
      );

      PeopleInSpaceEntity entity2 = PeopleInSpaceEntity(
        name: 'Some name',
        craft: 'Some creaft',
      );

      expect(entity, entity2);
    });
  });
}
