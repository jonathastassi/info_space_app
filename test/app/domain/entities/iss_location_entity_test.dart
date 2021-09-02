import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('Domain - entities - IssLocationMapEntity', () {
    test('Should be created', () {
      IssLocationMapEntity entity = IssLocationMapEntity(
        position: LatLng(85, 70),
        timestamp: '123123',
      );

      expect(entity.timestamp, '123123');
      expect(entity.position.latitude, 85);
      expect(entity.position.longitude, 70);
    });

    test('If same values, should be equal', () {
      IssLocationMapEntity entity = IssLocationMapEntity(
        position: LatLng(85, 70),
        timestamp: '123123',
      );

      IssLocationMapEntity entity2 = IssLocationMapEntity(
        position: LatLng(85, 70),
        timestamp: '123123',
      );

      expect(entity, entity2);
    });
  });
}
