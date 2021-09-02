import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/posititon_entity.dart';

void main() {
  group('Domain - entities - PositionEntity', () {
    test('Should be created', () {
      PositionEntity entity = PositionEntity(
        latitude: '123',
        longitude: '456',
      );

      expect(entity.latitude, '123');
      expect(entity.longitude, '456');
    });

    test('If same values, should be equal', () {
      PositionEntity entity = PositionEntity(
        latitude: '123',
        longitude: '456',
      );

      PositionEntity entity2 = PositionEntity(
        latitude: '123',
        longitude: '456',
      );

      expect(entity, entity2);
    });
  });
}
