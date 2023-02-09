import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_space_app/feature/iss_location_map/controller/iss_location_map_state.dart';
import 'package:info_space_app/feature/peoples_in_space/controller/peoples_in_space_state.dart';
import 'package:info_space_repository/info_space_repository.dart';

class IssLocationMapController extends ValueNotifier<IssLocationMapState> {
  IssLocationMapController({
    required InfoSpaceRepository infoSpaceRepository,
  })  : _infoSpaceRepository = infoSpaceRepository,
        super(InitialIssLocationMapState());

  final InfoSpaceRepository _infoSpaceRepository;

  MapController mapController = MapController();

  late Timer timer;

  Future<void> _getIssLocation() async {
    try {
      final result = await _infoSpaceRepository.getIssLocation();

      value = SuccessIssLocationMapState([...value, result]);
    } catch (error) {
      value = FailureIssLocationMapState(error as Exception);
    }
  }

  Future<void> initPage() async {
    startTimerGetIssLocation();
  }

  Future<void> startTimerGetIssLocation() async {
    timer = Timer.periodic(Duration(seconds: 5), (_) async {
      await _getIssLocation();

      // if (value.issLocationMapEntity != null) {
      //   mapController.move(
      //     value.issLocationMapEntity!.position,
      //     mapController.zoom,
      //   );
      // }
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
