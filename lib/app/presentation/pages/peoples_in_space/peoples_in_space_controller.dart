import 'package:flutter/cupertino.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/domain/usecases/get_peoples_in_space_usecase.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_state.dart';
import 'package:info_space_app/core/usecases/usecase.dart';

class PeoplesInSpaceController {
  final state = ValueNotifier<PeoplesInSpaceState>(PeoplesInSpaceState());
  final GetPeoplesInSpaceUsecase getPeoplesInSpaceUsecase;

  PeoplesInSpaceController({required this.getPeoplesInSpaceUsecase});

  Future<void> getPeoplesInSpace() async {
    state.value = PeoplesInSpaceState.loading();

    final result = await getPeoplesInSpaceUsecase.call(NoParams());

    result.fold((error) {
      state.value = PeoplesInSpaceState.setFailure(error);
    }, (data) {
      state.value = PeoplesInSpaceState.showList(data);
    });
  }

  void dispose() {
    state.dispose();
  }
}
