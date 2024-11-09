import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_space_app/feature/iss_location_map/controller/iss_location_map_state.dart';
import 'package:info_space_repository/info_space_repository.dart';
import 'package:latlong2/latlong.dart' as ll;

class IssLocationMapController extends ValueNotifier<IssLocationMapState> {
  IssLocationMapController({
    required InfoSpaceRepository infoSpaceRepository,
  })  : _infoSpaceRepository = infoSpaceRepository,
        super(InitialIssLocationMapState());

  final InfoSpaceRepository _infoSpaceRepository;

  MapController mapController = MapController();

  late Timer timer;

  void setZoom(double zoom) {
    if (value is SuccessIssLocationMapState) {
      value = (value as SuccessIssLocationMapState).copyWith(
        zoom: zoom,
      );
    }
  }

  Future<void> _getIssLocation() async {
    try {
      final result = await _infoSpaceRepository.getIssLocation();
      final markerList = value is SuccessIssLocationMapState
          ? (value as SuccessIssLocationMapState).markerHistory
          : [];
      final double zoom = value is SuccessIssLocationMapState
          ? (value as SuccessIssLocationMapState).zoom
          : 2;
      value = SuccessIssLocationMapState(
        markerHistory: [
          ...markerList,
          result.position,
        ],
        zoom: zoom,
      );
    } catch (error) {
      value = FailureIssLocationMapState(error as Exception);
    }
  }

  Future<void> initPage() async {
    await _getIssLocation();
    startTimerGetIssLocation();
  }

  Future<void> startTimerGetIssLocation() async {
    timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await _getIssLocation();

      if (value is SuccessIssLocationMapState) {
        final SuccessIssLocationMapState state =
            value as SuccessIssLocationMapState;
        final marker = state.getLastMarker;
        mapController.move(
          ll.LatLng(marker.latitude, marker.longitude),
          state.zoom,
        );
      }
    });
  }

  void closeTimerGetIssLocation() {
    timer.cancel();
  }

  @override
  void dispose() {
    closeTimerGetIssLocation();
    super.dispose();
  }
}
