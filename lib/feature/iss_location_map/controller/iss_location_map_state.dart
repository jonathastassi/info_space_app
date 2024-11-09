// import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
// import 'package:info_space_app/core/errors/failures.dart';
// import 'package:latlong2/latlong.dart';

import 'package:info_space_repository/info_space_repository.dart';

abstract class IssLocationMapState {}

class InitialIssLocationMapState extends IssLocationMapState {}

class SuccessIssLocationMapState extends IssLocationMapState {
  SuccessIssLocationMapState({
    required this.markerHistory,
    this.zoom = 2,
  });

  final List<LatLng> markerHistory;
  final double zoom;

  bool get hasMarkerHistory => markerHistory.isNotEmpty;

  LatLng get getLastMarker => markerHistory.last;

  bool get canMinusZoom => zoom > 1;
  bool get canAddZoom => zoom < 10;

  SuccessIssLocationMapState copyWith({
    List<LatLng>? markerHistory,
    double? zoom,
  }) {
    return SuccessIssLocationMapState(
      markerHistory: markerHistory ?? this.markerHistory,
      zoom: zoom ?? this.zoom,
    );
  }
}

class LoadingIssLocationMapState extends IssLocationMapState {}

class FailureIssLocationMapState extends IssLocationMapState {
  FailureIssLocationMapState(this.failure);

  final Exception failure;
}
