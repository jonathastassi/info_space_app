import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/data/models/people_in_space_model.dart';

void main() {
  group('Data - models - PeopleInSpaceModel', () {
    test('Should be created', () {
      PeopleInSpaceModel entity = PeopleInSpaceModel(
        name: 'Some name',
        craft: 'Some creaft',
      );

      expect(entity.name, 'Some name');
      expect(entity.craft, 'Some creaft');
    });

    test('Create a new model from map(json) ', () {
      final json = {
        'name': 'some_name',
        'craft': 'some_craft',
      };

      PeopleInSpaceModel model = PeopleInSpaceModel.fromJson(json);

      expect(model.name, 'some_name');
      expect(model.craft, 'some_craft');
    });
  });
}
