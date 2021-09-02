import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  final String latitude;
  final String longitude;

  PositionEntity({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}
