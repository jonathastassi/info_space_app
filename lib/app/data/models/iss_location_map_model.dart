import 'package:info_space_app/app/data/models/position_model.dart';
import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';

class IssLocationMapModel extends IssLocationMapEntity {
  IssLocationMapModel({
    required PositionModel position,
    required String timestamp,
  }) : super(
          position: position,
          timestamp: timestamp,
        );
}
