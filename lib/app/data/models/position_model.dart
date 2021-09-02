import 'package:info_space_app/app/domain/entities/posititon_entity.dart';

class PositionModel extends PositionEntity {
  PositionModel({
    required String latitude,
    required String longitude,
  }) : super(
          latitude: latitude,
          longitude: longitude,
        );
}
