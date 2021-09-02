import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:latlong2/latlong.dart';

class IssLocationMapModel extends IssLocationMapEntity {
  IssLocationMapModel({
    required LatLng position,
    required String timestamp,
  }) : super(
          position: position,
          timestamp: timestamp,
        );
}
