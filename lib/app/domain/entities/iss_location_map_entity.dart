import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class IssLocationMapEntity extends Equatable {
  final String timestamp;
  final LatLng position;

  IssLocationMapEntity({
    required this.timestamp,
    required this.position,
  });

  @override
  List<Object> get props => [timestamp, position];
}
