import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/core/errors/failures.dart';

class PeoplesInSpaceState {
  final List<PeopleInSpaceEntity> peopleInSpaceList;
  final bool isLoading;
  final Failure? failure;

  PeoplesInSpaceState({
    this.peopleInSpaceList = const <PeopleInSpaceEntity>[],
    this.isLoading = false,
    this.failure,
  });

  factory PeoplesInSpaceState.loading() => PeoplesInSpaceState(isLoading: true);

  factory PeoplesInSpaceState.showList(
          List<PeopleInSpaceEntity> peopleInSpaceList) =>
      PeoplesInSpaceState(
        isLoading: false,
        peopleInSpaceList: peopleInSpaceList,
        failure: null,
      );

  factory PeoplesInSpaceState.setFailure(Failure failure) =>
      PeoplesInSpaceState(
        isLoading: false,
        failure: failure,
      );
}
