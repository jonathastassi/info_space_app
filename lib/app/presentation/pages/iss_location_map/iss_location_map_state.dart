import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:latlong2/latlong.dart';

class IssLocationMapState {
  final IssLocationMapEntity? issLocationMapEntity;
  final bool isLoading;
  final List<LatLng> markerHistory;
  final Failure? failure;

  IssLocationMapState({
    this.isLoading = false,
    this.issLocationMapEntity,
    this.markerHistory = const [],
    this.failure,
  });

  factory IssLocationMapState.initial() => IssLocationMapState(
        isLoading: true,
        issLocationMapEntity: null,
        failure: null,
      );

  factory IssLocationMapState.setFailure(Failure failure) =>
      IssLocationMapState(
        isLoading: false,
        issLocationMapEntity: null,
        failure: failure,
      );

  factory IssLocationMapState.setLocation(
    IssLocationMapEntity entity,
    List<LatLng> markerHistory,
  ) =>
      IssLocationMapState(
        isLoading: false,
        issLocationMapEntity: entity,
        failure: null,
        markerHistory: [...markerHistory, entity.position],
      );
}
