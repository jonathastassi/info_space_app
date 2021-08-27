import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/data/models/people_in_space_model.dart';

void main() {
  group('Data - models - PeopleInSpaceModel', () {
    test('Should be created', () {
      PeopleInSpaceModel model = PeopleInSpaceModel(
        name: 'Some name',
        craft: 'Some craft',
      );

      expect(model.name, 'Some name');
      expect(model.craft, 'Some craft');
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

    test('toJson should return a json', () {
      PeopleInSpaceModel model = PeopleInSpaceModel(
        name: 'Some name',
        craft: 'Some craft',
      );

      final json = model.toJson();

      expect(json['name'], 'Some name');
      expect(json['craft'], 'Some craft');
    });
  });
}
