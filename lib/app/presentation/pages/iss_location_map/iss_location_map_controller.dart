import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_space_app/app/domain/usecases/get_iss_location_map_usecase.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_state.dart';
import 'package:info_space_app/app/presentation/utils/show_snackbar.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/usecases/usecase.dart';

class IssLocationMapController {
  final MapController mapController = MapController();

  final state =
      ValueNotifier<IssLocationMapState>(IssLocationMapState.initial());

  final GetIssLocationMapUsecase getIssLocationMapUsecase;

  late final Timer timer;

  IssLocationMapController({
    required this.getIssLocationMapUsecase,
  });

  Future<void> _getIssLocation() async {
    final result = await getIssLocationMapUsecase.call(NoParams());

    result.fold((error) {
      state.value = IssLocationMapState.setFailure(error);
    }, (data) {
      state.value =
          IssLocationMapState.setLocation(data, state.value.markerHistory);
    });
  }

  Future<void> startTimerGetIssLocation() async {
    timer = Timer.periodic(Duration(seconds: 5), (_) async {
      await _getIssLocation();

      if (state.value.issLocationMapEntity != null) {
        mapController.move(
          state.value.issLocationMapEntity!.position,
          mapController.zoom,
        );
      }

      if (state.value.failure != null &&
          state.value.failure != NoConnectionFailure()) {
        showErrorSnackbar(
          title: 'Error',
          error: state.value.failure,
        );
      }
    });
  }

  void closeTimerGetIssLocation() {
    timer.cancel();
  }

  void dispose() {
    closeTimerGetIssLocation();
    state.dispose();
  }
}
