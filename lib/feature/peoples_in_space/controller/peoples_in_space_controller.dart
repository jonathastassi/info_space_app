import 'package:flutter/material.dart';
import 'package:info_space_app/feature/peoples_in_space/controller/peoples_in_space_state.dart';
import 'package:info_space_repository/info_space_repository.dart';

class PeoplesInSpaceController extends ValueNotifier<PeoplesInSpaceState> {
  PeoplesInSpaceController({
    required InfoSpaceRepository infoSpaceRepository,
  })  : _infoSpaceRepository = infoSpaceRepository,
        super(InitialPeoplesInSpaceState());

  final InfoSpaceRepository _infoSpaceRepository;

  Future<void> getPeoplesInSpace() async {
    try {
      value = LoadingPeoplesInSpaceState();

      final result = await _infoSpaceRepository.getPeoplesInSpace();

      value = SuccessPeoplesInSpaceState(result);
    } catch (error) {
      value = FailurePeoplesInSpaceState(error as Exception);
    }
  }
}
