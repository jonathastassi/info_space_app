import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:info_space_app/app/domain/entities/posititon_entity.dart';

void main() {
  group('Domain - entities - IssLocationMapEntity', () {
    test('Should be created', () {
      IssLocationMapEntity entity = IssLocationMapEntity(
        position: PositionEntity(
          latitude: '123',
          longitude: '456',
        ),
        timestamp: '123123',
      );

      expect(entity.timestamp, '123123');
      expect(entity.position.latitude, '123');
      expect(entity.position.longitude, '456');
    });

    test('If same values, should be equal', () {
      IssLocationMapEntity entity = IssLocationMapEntity(
        position: PositionEntity(
          latitude: '123',
          longitude: '456',
        ),
        timestamp: '123123',
      );

      IssLocationMapEntity entity2 = IssLocationMapEntity(
        position: PositionEntity(
          latitude: '123',
          longitude: '456',
        ),
        timestamp: '123123',
      );

      expect(entity, entity2);
    });
  });
}
